import {LEVEL_STOCK_HIGH, 
        LEVEL_STOCK_MEDIUM,
        AUDIO_CAT,
        TECH_ACC_CAT,
        TECH_CAT,
        FASHION_CAT,
        SPORT_CAT,
      OTHER_CAT} from './util/constants';

cube(`Products`, {
  sql: `SELECT * FROM store.products`,
  title: `Productos`,
  
  joins: {
    Stores: {
      sql: `${CUBE}.store_id = ${Stores}.id`,
      relationship: `belongsTo`
    }
  },
  
  measures: {
    count: {
      title: `Contar`,
      type: `number`,
      sql: `count(*)`
    },
    countSouthAmerica: {
      title: `Contar Sur América`,
      type: `number`,
      sql: `count(*)`,
      filters: [
        {sql: `${Countries.continent} = 'Sur América'`}
      ],
      shown: false
    },
    countNorthAmerica: {
      title: `Contar Norte América`,
      type: `number`,
      sql: `count(*)`,
      filters: [
        {sql: `${Countries.continent} = 'Norte América'`}
      ],
      shown: false
    }
  },
  
  dimensions: {
    price: {
      title: `Precio`,
      sql: `price`,
      type: `number`
    },

    stock: {
      sql: `stock`,
      type: `number`,
      shown: false
    },

    levelStock: {
      type: `string`,
      title: `Nivel Stock`,
      case: {
        when: [
          {sql: `${CUBE}.stock > ${LEVEL_STOCK_HIGH}`, label: `Alto`},
          {sql: `${CUBE}.stock >= ${LEVEL_STOCK_MEDIUM} and ${CUBE}.stock <= ${LEVEL_STOCK_HIGH}`, label: `Medio`},
          {sql: `${CUBE}.stock < ${LEVEL_STOCK_MEDIUM}`, label: `Bajo`}
        ]
      }
    },

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
      //shown: false
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
    },

    category: { 
      type: `string`,
      title: `Categoría`,
      case: {
        when: [
            { sql: `upper(${CUBE}.name) ~ upper('${AUDIO_CAT[0]}') = true or upper(${CUBE}.name) ~ upper('${AUDIO_CAT[1]}') = true`, label: `Audio` },
            { sql: `upper(${CUBE}.name) ~ upper('${FASHION_CAT[0]}') = true or 
                    upper(${CUBE}.name) ~ upper('${FASHION_CAT[1]}') = true or
                    upper(${CUBE}.name) ~ upper('${FASHION_CAT[2]}') = true or
                    upper(${CUBE}.name) ~ upper('${FASHION_CAT[3]}') = true or
                    upper(${CUBE}.name) ~ upper('${FASHION_CAT[4]}') = true`, label: `Moda` },
            { sql: `upper(${CUBE}.name) ~ upper('${SPORT_CAT[0]}') = true or 
                    upper(${CUBE}.name) ~ upper('${SPORT_CAT[1]}') = true or 
                    upper(${CUBE}.name) ~ upper('${SPORT_CAT[2]}') = true`, label: `Deportes` },
            { sql: `upper(${CUBE}.name) ~ upper('${TECH_CAT[0]}') = true or
                    upper(${CUBE}.name) ~ upper('${TECH_CAT[1]}') = true or 
                    upper(${CUBE}.name) ~ upper('${TECH_CAT[2]}') = true or 
                    upper(${CUBE}.name) ~ upper('${TECH_CAT[3]}') = true`, label: `Tecnología` },
            { sql: `upper(${CUBE}.name) ~ upper('${TECH_ACC_CAT[0]}') = true or 
                    upper(${CUBE}.name) ~ upper('${TECH_ACC_CAT[1]}') = true`, label: `Accesorios Tecnología` },
         ]
         ,else: {label: `${OTHER_CAT}`}
      }
    }
  }
});
