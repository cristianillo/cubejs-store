cube(`ProductsListing`, {
  sql: `SELECT * FROM store.products_listing`,
  
  joins: {
    Purchases: {
      sql: `${CUBE}.purchase_id = ${Purchases}.id`,
      relationship: `belongsTo`
    },
    
    Products: {
      sql: `${CUBE}.products_id = ${Products}.id`,
      relationship: `belongsTo`
    }
  },
  
  measures: {
    count: {
      type: `count`,
      drillMembers: [id, updateAt],
      shown: false
    },
    
    quantity: {
      sql: `quantity`,
      type: `sum`,
      shown: false
    }
  },
  
  dimensions: {
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true
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
