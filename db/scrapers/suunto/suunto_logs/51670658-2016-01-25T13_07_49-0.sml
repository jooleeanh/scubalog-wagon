<?xml version="1.0" encoding="utf-8"?>
<sml SdkVersion="2.6.6" Modified="2012-09-22T10:39:51" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://www.suunto.com/schemas/sml">
	<DeviceLog>
		<Header>
			<Battery>3</Battery>
			<DateTime>2016-01-25T13:07:49</DateTime>
			<Duration>4</Duration>
			<Depth>
				<Max>1.53</Max>
				<Avg>0.82</Avg>
			</Depth>
			<Diving>
				<DiveMode>Free</DiveMode>
				<Conservatism>0</Conservatism>
				<Altitude>0</Altitude>
				<SurfaceTime>180</SurfaceTime>
				<NumberInSeries>5</NumberInSeries>
				<SurfacePressure>100500</SurfacePressure>
				<StartTissue/>
				<EndTissue/>
			</Diving>
			<SampleInterval>1</SampleInterval>
		</Header>
		<Device>
			<Name>Suunto D6i</Name>
			<SerialNumber>51670658</SerialNumber>
			<Info>
				<SW>1.2.10</SW>
				<HW>0.0.0</HW>
				<BSL>0.0.0</BSL>
			</Info>
		</Device>
		<Samples>
			<Sample>
				<Time>0</Time>
				<Events>
					<State>
						<Type>Below Surface</Type>
						<Active>true</Active>
					</State>
					<State>
						<Type>Wet Outside</Type>
						<Active>true</Active>
					</State>
					<State>
						<Type>Below Wet Activation Depth</Type>
						<Active>true</Active>
					</State>
				</Events>
			</Sample>
			<Sample>
				<Time>0</Time>
				<Depth>1.53</Depth>
				<Temperature>303.15</Temperature>
				<Events>
					<State>
						<Type>Dive Active</Type>
						<Active>true</Active>
					</State>
				</Events>
			</Sample>
			<Sample>
				<Time>1</Time>
				<Depth>1.53</Depth>
				<Temperature>303.15</Temperature>
			</Sample>
			<Sample>
				<Time>2</Time>
				<Depth>1.03</Depth>
				<Temperature>303.15</Temperature>
			</Sample>
			<Sample>
				<Time>3</Time>
				<Depth>0.58</Depth>
				<Temperature>303.15</Temperature>
				<Events>
					<State>
						<Type>Below Wet Activation Depth</Type>
						<Active>false</Active>
					</State>
				</Events>
			</Sample>
			<Sample>
				<Time>4</Time>
				<Depth>0.16</Depth>
				<Temperature>303.15</Temperature>
				<Events>
					<State>
						<Type>Below Surface</Type>
						<Active>false</Active>
					</State>
				</Events>
			</Sample>
		</Samples>
	</DeviceLog>
</sml>
