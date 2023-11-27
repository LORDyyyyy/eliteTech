import { readFile, writeFile } from 'fs/promises';

/**
 * FileStorage class for handling CRUD operations on JSON files.
 */
export default class FileStorage {
  /**
   * Constructs a new FileStorage instance and triggers a data reload.
   */
  constructor() {
    this.reload();
  }

  /**
   * Reloads the data by setting it to null.
   */
  reload() {
    this.data = null;
  }

  /**
   * Retrieves a record based on the type of the provided object.
   * @param {Object} obj - The object whose type is used for retrieval.
   * @returns {Object|null} - The retrieved record or null if not found.
   */
  async type(obj) {
    this.reload();
    this.data = JSON.parse(
      await readFile(`${process.cwd()}/models/storage/json/type.json`, 'utf8')
    );
    for (const record of this.data) {
      if (record.type === obj.constructor.name.toLowerCase()) {
        return record;
      }
    }
    return null;
  }

  /**
   * Retrieves all records of a specified class.
   * @param {Function} cls - The class of objects to retrieve.
   * @returns {Array} - An array of records.
   */
  async all(cls) {
    this.reload();
    this.data = JSON.parse(
      await readFile(
        `${process.cwd()}/models/storage/json/${cls.name.toLowerCase()}.json`,
        'utf8'
      )
    );
    return this.data;
  }

  /**
   * Retrieves a specific record based on class and object ID.
   * @param {Function} cls - The class of the object.
   * @param {Object} obj - The object to retrieve.
   * @returns {Object|null} - The retrieved record or null if not found.
   */
  async get(cls, obj) {
    this.reload();
    await this.all(cls);
    for (const record of this.data) {
      if (record.id == obj.id) {
        return record;
      }
    }
    return null;
  }

  /**
   * Adds a new record to the specified class.
   * @param {Function} cls - The class of the object.
   * @param {Object} obj - The object to add.
   * @returns {number} - The ID of the added object.
   */
  async add(cls, obj) {
    this.reload();
    await this.all(cls);
    this.data.push(JSON.parse(obj.toString()));
    await this.save(cls, this.data);
    return obj.id;
  }

  /**
   * Updates an existing record in the specified class.
   * @param {Function} cls - The class of the object.
   * @param {Object} obj - The object with updated values.
   * @returns {number|null} - The ID of the updated object or null if not found.
   */
  async update(cls, obj) {
    this.reload();
    await this.all(cls);
    for (const record of this.data) {
      if (record.id == obj.id) {
        for (const property in obj) {
          if (property == 'id') continue;
          record[property] = obj[property];
        }
        await this.save(cls, this.data);
        return obj.id;
      }
    }
    return null;
  }

  /**
   * Deletes a record from the specified class.
   * @param {Function} cls - The class of the object.
   * @param {Object} obj - The object to delete.
   * @returns {number|null} - The ID of the deleted object or null if not found.
   */
  async delete(cls, obj) {
    this.reload();
    await this.all(cls);
    for (const record of this.data) {
      if (record.id == obj.id) {
        this.data.splice(this.data.indexOf(record), 1);
        await this.save(cls, this.data);
        return obj.id;
      }
    }
    return null;
  }

  /**
   * Saves data to a JSON file based on the product name.
   * @param {Function} product - The class representing the product.
   * @param {Array} data - The data to be saved.
   */
  async save(product, data) {
    await writeFile(
      `${process.cwd()}/models/storage/json/${product.name.toLowerCase()}.json`,
      JSON.stringify(data),
      'utf8'
    );
  }
}
