# frozen_string_literal: true

#
# Copyright (C) 2021 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

class AddIncludeReplyPreviewToDiscussionEntry < ActiveRecord::Migration[6.0]
  tag :predeploy
  disable_ddl_transaction!

  def up
    new_pg = connection.postgresql_version >= 11_00_00 # rubocop:disable Style/NumericLiterals
    defaults = new_pg ? { default: false, null: false } : {}
    add_column :discussion_entries, :include_reply_preview, :boolean, if_not_exists: true, **defaults

    unless new_pg
      change_column_default :discussion_entries, :include_reply_preview, false
      DataFixup::BackfillNulls.run(DiscussionEntry, [:include_reply_preview], default_value: false)
      change_column_null :discussion_entries, :include_reply_preview, false
    end
  end

  def down
    remove_column :discussion_entries, :include_reply_preview
  end
end
