class ManageController < ApplicationController
  def table_list
    @table_list = ActiveRecord::Base.connection.tables
  end

  def column_list
    @table_name = params[:table]
    # table_nameを単数形・キャメル・クラスオブジェクトに変換する
    capitalized_table_name = @table_name.singularize.camelcase.constantize
    @column_names = capitalized_table_name.columns.map{ |column| column.name}
    @column_types = capitalized_table_name.columns.map{ |column| column.type}
    @columns = capitalized_table_name.all.order(id: :desc)
  end
end
