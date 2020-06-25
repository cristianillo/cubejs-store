cube(`ProductsListing`, {
  sql: `SELECT * FROM store.products_listing`,
  title: `Lista Productos`,
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
      type: `number`,
      title: `Contar`,
      sql: `count(*)`
    },
    
    quantityTotal: {
      title: `Suma Cantidad`,
      sql: `quantity`,
      type: `sum`,
      //shown: false
    },

    valueSoldProducts: {
      title: `Valor Vendido`,
      sql: `sum(${CUBE.quantity} * ${Products.price})`,
      type: `number`
    }


  },
  
  dimensions: {
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true
    },
    
    quantity: {
      type: `number`,
      sql: `quantity`,
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
