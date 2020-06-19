cube(`Stores`, {
  sql: `SELECT * FROM store.stores`,
  
  joins: {
    Countries: {
      sql: `${CUBE}.country_id = ${Countries.id}`,
      relationship: `belongsTo`
    }
    
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id, name, updateAt],
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
