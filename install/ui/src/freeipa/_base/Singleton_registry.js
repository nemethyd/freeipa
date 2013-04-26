/*  Authors:
 *    Petr Vobornik <pvoborni@redhat.com>
 *
 * Copyright (C) 2012 Red Hat
 * see file 'COPYING' for use and warranty information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

define(['dojo/_base/declare',
        'dojo/_base/array',
        'dojo/_base/lang',
        './construct',
        './Builder',
        './Construct_registry'
        ], function(declare, array, lang, construct, Builder, Construct_registry) {

    var Singleton_registry = declare(null, {
        /**
         * Registry for storing singleton instances of various items based
         * on their type.
         *
         * @class
         * @name Singleton_registry
         */

        /**
         * Internal map for instances
         * @protected
         * @type Object
         */
        _map: {},

        /**
         * Builder used for building new instances. Builder has to have a
         * Constructor registry set.
         * @type Builder
         */
        builder: null,

        /**
         * Gets an instance of given type. Creates a new one if it doesn't
         * exist.
         *
         * When an object is passed in, the function returns it.
         *
         * @param type {String|Object} Type's name. Or the the object itself.
         * @returns Object|null
         */
        get: function(type) {

            if (typeof type === 'object') return type;

            var obj = this._map[type];

            if (!obj) {
                if (!this.builder) return null;
                try {
                    obj = this._map[type] = this.builder.build(type);
                } catch (e) {
                    if (e.code === 'no-ctor-fac') obj = null;
                }
            }

            return obj;
        },

        /**
         * Set object of given type - overwrites existing
         *
         * @param {String} type
         * @param {anything} object
         */
        set: function (type, obj) {
            this._map[type] = obj;
        },

        /**
         * Removes object of given type from registry
         *
         * @param {String} type
         */
        remove: function(type) {

            var undefined;
            this._map[type] = undefined;
        },

        /**
         * Registers construction specification
         *
         * @param type {String|Object} type or construction spec
         * @param func {Function} ctor or factory function
         * @param [default_spec] {Object} default spec object for given type
         *
         * @returns Object
         */
        register: function(type, func, default_spec) {
            if (!lang.exists('builder.registry', this)) {
                throw {
                    error: 'Object Initialized Exception: builder not initalized',
                    context: this
                };
            }

            this.builder.registry.register(type, func, default_spec);
        },


        constructor: function(spec) {

            spec = spec || {};
            this._map = {};
            this.builder = spec.builder || new Builder({
                registry: new Construct_registry()
            });
        }
    });

    return Singleton_registry;
});