from neomodel import UniqueIdProperty, StringProperty, StructuredNode, Relationship
from neomodel.contrib.spatial_properties import PointProperty


class User(StructuredNode):
    id = UniqueIdProperty()
    auth_id = StringProperty()
    following = Relationship("User", "FOLLOWS")


class Trip(StructuredNode):
    id = UniqueIdProperty()


class PointOfInterest(StructuredNode):
    entity_id = UniqueIdProperty()
    location = PointProperty(crs='wgs-84')
