cube(`Products`, {
  sql: `SELECT * FROM store.products`,
  
  joins: {
    Stores: {
      sql: `${CUBE}.store_id = ${Stores}.id`,
      relationship: `belongsTo`
    }
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id, name, updateAt],
      shown: false
    },
    
    price: {
      sql: `price`,
      type: `sum`,
      shown: false
    }
  },
  
  dimensions: {
    description: {
      sql: `description`,
      type: `string`,
      shown: false
    },
    
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true,
    },
    
    name: {
      sql: `name`,
      type: `string`,
      shown: false
    },
    
    code: {
      sql: `code`,
      type: `string`,
      shown: false
    },
    
    createAt: {
      sql: `create_at`,
      type: `time`,
      shown: false
    },
    
    updateAt: {
      sql: `update_at`,
      type: `time`,
      shown: false
    }
  }
});
