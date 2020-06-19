cube(`Countries`, {
  sql: `SELECT * FROM store.countries`,
  
  joins: {
    
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id, name],
      shown: false
    }
  },
  
  dimensions: {
    code: {
      sql: `code`,
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
    }
  }
});
