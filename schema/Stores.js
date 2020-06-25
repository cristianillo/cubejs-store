cube(`Stores`, {
  sql: `SELECT * FROM store.stores`,
  title: `Tiendas`,
  joins: {
    Countries: {
      sql: `${CUBE}.country_id = ${Countries.id}`,
      relationship: `belongsTo`
    }
    
  },
  
  measures: {
    count: {
      title: `Contar`,
      type: `number`,
      sql: `count(*)`
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
      title: `Nombre`,
      sql: `name`,
      type: `string`,
     // shown: false
    },
    
    code: {
      sql: `code`,
      type: `string`,
      shown: false
    },
    
    createAt: {
      title: `Fecha Creación`,
      sql: `create_at`,
      type: `time`,
      //shown: false
    },
    
    updateAt: {
      sql: `update_at`,
      type: `time`,
      shown: false
    }
  }
});
