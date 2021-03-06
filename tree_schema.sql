-- Tree table. If there are multiple trees, then there are multiple rows in
-- this table.
CREATE TABLE tree {
	tree_id	INTEGER	PRIMARY KEY,
	name	VARCHAR(32) NOT NULL, -- Tree name/label. How big should this be?
	is_rooted	BOOLEAN DEFAULT TRUE NOT NULL, -- True if rooted.
	node_id	INTEGER NOT NULL -- ID of starting node. Root node if rooted.
};

-- Tree metadata table. All tree metadata is associated with at least one tree.
-- Stores metadata related to a tree. Values are stored here and related to a
-- metadata type id. This id, as well as what type it represents, is in the
-- tree_metadata_type relation.
CREATE TABLE tree_metadata {
	tree_metadata_id	INTEGER	PRIMARY KEY,
	value LONGBLOB, -- This will support any type of value for any metadata a
					-- user wants to store. longblob type is not supported in
					-- postgresql. This data type might change.
--	value BYTEA,	-- For postgres, if we still use BLOBs since LONGBLOB is
					-- not supported
	tree_id	INTEGER NOT NULL,
	tree_metadata_type_id INTEGER NOT NULL,
	FOREIGN KEY (tree_id) REFERENCES tree(tree_id),
	FOREIGN KEY (tree_metadata_type_id) REFERENCES tree_metadata_type(tree_metadata_type_id)
};

-- Tree metadata type table. All tree metadata is of at least one type.
-- Metadata types for trees are stored here. Additional types can  be added as
-- needed.
CREATE TABLE tree_metadata_type {
	tree_metadata_type_id	INTEGER	PRIMARY KEY,
	name	VARCHAR(255) NOT NULL,	-- The name of this type of metadata: eg,
		-- reconstructed_sequence, tree_color, organism, etc... There should
		-- be only one name/tree_metadata_type_id pairing allowed.
	description	TEXT,	-- A description of the metadata type: eg,
						-- "reconstructed_sequence is the estimated sequence
						-- of this ancestor tree"
	UNIQUE (tree_metadata_type_id, name)
};

-- Node table. All nodes belong in a tree, and so each node refers to its
-- containing tree. labels can be used to give it a [visible] label.
CREATE TABLE node {
	node_id	INTEGER	PRIMARY KEY,
	tree_id	INTEGER NOT NULL,
	label VARCHAR(255), -- Node label. This is optional.
	FOREIGN KEY (tree_id) REFERENCES tree(tree_id)
};

-- Node metadata table. All node metadata is associated with at least one node.
-- Stores metadata related to a node. Values are stored here and related to a
-- metadata type id. This id, as well as what type it represents, is in the
-- node_metadata_type relation.
CREATE TABLE node_metadata {
	node_metadata_id	INTEGER	PRIMARY KEY,
	value LONGBLOB, -- This will support any type of value for any metadata a
					-- user wants to store. longblob type is not supported in
					-- postgresql. This data type might change.
--	value BYTEA,	-- For postgres, if we still use BLOBs since LONGBLOB is
					-- not supported
	node_id	INTEGER NOT NULL,
	node_metadata_type_id INTEGER NOT NULL,
	FOREIGN KEY (node_id) REFERENCES node(node_id),
	FOREIGN KEY (node_metadata_type_id) REFERENCES node_metadata_type(node_metadata_type_id)
};

-- Node metadata type table. All node metadata is of at least one type.
-- Metadata types for nodes are stored here. Additional types can  be added as
-- needed.
CREATE TABLE node_metadata_type {
	node_metadata_type_id	INTEGER	PRIMARY KEY,
	name	VARCHAR(255) NOT NULL,	-- The name of this type of metadata: eg,
		-- reconstructed_sequence, node_color, organism, etc... There should
		-- be only one name/node_metadata_type_id pairing allowed.
	description	TEXT,	-- A description of the metadata type: eg,
						-- "reconstructed_sequence is the estimated sequence
						-- of this ancestor node"
	UNIQUE (node_metadata_type_id, name)
};

-- Edge table. Edges hold the actual distance between connected nodes. Since an
-- edge can only connect two nodes, then it only has a child and a parent node.
CREATE TABLE edge {
	edge_id	INTEGER PRIMARY KEY,
	label	VARCHAR(255), -- An optional label for an edge.
	length	REAL DEFAULT 0 NOT NULL,
	-- Endpoint of the edge connected to the child node.
	child_node_id	INTEGER NOT NULL,
	-- Startpoint of the edge, connected to the parent node.
	parent_node_id	INTEGER NOT NULL,
	FOREIGN KEY (child_node_id) REFERENCES node(node_id),
	FOREIGN KEY (parent_node_id) REFERENCES node(node_id),
	UNIQUE (child_node_id, parent_node_id)
};

-- Edge metadata table. All edge metadata is associated with at least one edge.
-- Stores metadata related to a edge. Values are stored here and related to a
-- metadata type id. This id, as well as what type it represents, is in the
-- edge_metadata_type relation.
CREATE TABLE edge_metadata {
	edge_metadata_id	INTEGER	PRIMARY KEY,
	value LONGBLOB, -- This will support any type of value for any metadata a
					-- user wants to store. longblob type is not supported in
					-- postgresql. This data type might change.
--	value BYTEA,	-- For postgres, if we still use BLOBs since LONGBLOB is
					-- not supported
	edge_id	INTEGER NOT NULL,
	edge_metadata_type_id INTEGER NOT NULL,
	FOREIGN KEY (edge_id) REFERENCES edge(edge_id),
	FOREIGN KEY (edge_metadata_type_id) REFERENCES edge_metadata_type(edge_metadata_type_id)
};

-- Edge metadata type table. All edge metadata is of at least one type.
-- Metadata types for edges are stored here. Additional types can  be added as
-- needed.
CREATE TABLE edge_metadata_type {
	edge_metadata_type_id	INTEGER	PRIMARY KEY,
	name	VARCHAR(255) NOT NULL,	-- The name of this type of metadata: eg,
		-- reconstructed_sequence, edge_color, organism, etc... There should
		-- be only one name/edge_metadata_type_id pairing allowed.
	description	TEXT,	-- A description of the metadata type: eg,
						-- "reconstructed_sequence is the estimated sequence
						-- of this ancestor edge"
	UNIQUE (edge_metadata_type_id, name)
};
