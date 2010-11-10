-- Tree table. If there are multiple trees, then there are multiple rows in this table.
CREATE TABLE tree {
	tree_id	INTEGER	PRIMARY KEY,
	name	VARCHAR(32) DEFAULT TRUE,
	is_rooted	BOOLEAN NOT NULL,
	node_id	INTEGER NOT NULL
};

-- Node table. All nodes belong in a tree, and so each node refers to its containing tree.
-- labels can be used to give it a [visible] label.
CREATE TABLE node {
	node_id	INTEGER	PRIMARY KEY,
	label VARCHAR(255),
	tree_id	INTEGER,
	FOREIGN KEY (tree_id) REFERENCES tree(tree_id)
};

-- Tree root table. In the case of rooted trees, if there is more than one possible root,
-- then there are multiple entries in here per tree but referring to different nodes.
-- (Hence the restriction on tree/node id pairs being unique.)
CREATE TABLE tree_root {
	tree_root_id	INTEGER PRIMARY KEY,
	tree_id	INTEGER NOT NULL,
	node_id	INTEGER	NOT NULL,
	is_alternate	BOOLEAN DEFAULT TRUE,
	significance	REAL,
	FOREIGN KEY (tree_id) REFERENCES tree(tree_id),
	FOREIGN KEY (node_id) REFERENCES node(node_id),
	UNIQUE (tree_id, node_id)
}

-- Node/organism table. This relates nodes to organisms. Basically, any node which represents
-- a organism in a tree shows up here, with both its node id and the represented organism id.
-- Perhaps a better name is "leaf_nodes", but this name is taken from the BioSQL rough
-- equivalent: node_taxon
CREATE TABLE node_organism { -- Rename to leaf_node ??
	node_organism_id	INTEGER PRIMARY KEY,
	node_id	INTEGER NOT NULL,
	organism_id	INTEGER	NOT NULL,
	FOREIGN KEY (node_id) REFERENCES node(node_id),
	FOREIGN KEY (organism_id) REFERENCES organism(organism_id)
}

-- Edge table. Edges hold the actual distance between connected nodes. Since an edge
-- can only connect two nodes, then it only has a child and a parent node.
CREATE TABLE edge {
	edge_id	INTEGER PRIMARY KEY,
	child_node_id	INTEGER,
	parent_node_id	INTEGER,
	FOREIGN KEY (child_node_id) REFERENCES node(node_id),
	FOREIGN KEY (parent_node_id) REFERENCES node(node_id),
	UNIQUE (child_node_id, parent_node_id)
};
