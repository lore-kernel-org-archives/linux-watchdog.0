Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43744 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbdF2U1X (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Jun 2017 16:27:23 -0400
Subject: Re: [PATCH v5 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
To: Rob Herring <robh@kernel.org>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-8-hauke@hauke-m.de>
 <20170623221224.fhfc6ezydd3uglfr@rob-hp-laptop>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1171930b-769b-f0ea-778e-ddcd11b20775@hauke-m.de>
Date: Thu, 29 Jun 2017 22:27:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170623221224.fhfc6ezydd3uglfr@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 06/24/2017 12:12 AM, Rob Herring wrote:
> On Wed, Jun 21, 2017 at 12:37:34AM +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This adds the initial documentation for the RCU module (a MFD device
>> which provides USB PHYs, reset controllers and more).
>>
>> The RCU register range is used for multiple purposes. Mostly one devic=
e
>> uses one or multiple register exclusively, but for some registers some
>> bits are for one driver and some other bits are for a different driver=
.
>> With this patch all accesses to the RCU registers will go through
>> syscon.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 95 +++++++++++++=
+++++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.=
txt
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/D=
ocumentation/devicetree/bindings/mips/lantiq/rcu.txt
>> new file mode 100644
>> index 000000000000..9c875f4f3c90
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>> @@ -0,0 +1,95 @@
>> +Lantiq XWAY SoC RCU binding
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +
>> +This binding describes the RCU (reset controller unit) multifunction =
device,
>> +where each sub-device has it's own set of registers.
>> +
>> +The RCU register range is used for multiple purposes. Mostly one devi=
ce
>> +uses one or multiple register exclusively, but for some registers som=
e
>> +bits are for one driver and some other bits are for a different drive=
r.
>> +With this patch all accesses to the RCU registers will go through
>> +syscon.
>> +
>> +
>> +---------------------------------------------------------------------=
----------
>> +Required properties:
>> +- compatible	: The first and second values must be:
>> +		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
>> +- reg		: The address and length of the system control registers
>> +
>> +
>> +---------------------------------------------------------------------=
----------
>> +Example of the RCU bindings on a xRX200 SoC:
>> +	rcu0: rcu@203000 {
>> +		compatible =3D "lantiq,xrx200-rcu", "simple-mfd", "syscon";
>> +		reg =3D <0x203000 0x100>;
>> +		ranges =3D <0x0 0x203000 0x100>;
>> +		big-endian;
>> +
>> +		gphy0: gphy@0 {
>=20
> unit address should match reg, so "phy@20"

done

>> +			compatible =3D "lantiq,xrx200a2x-gphy";
>> +			reg =3D <0x20 0x4>;
>> +
>> +			resets =3D <&reset0 31 30>, <&reset1 7 7>;
>> +			reset-names =3D "gphy", "gphy2";
>> +			lantiq,gphy-mode =3D <GPHY_MODE_GE>;
>> +		};
>> +
>> +		gphy1: gphy@1 {
>=20
> phy@68

done

>> +			compatible =3D "lantiq,xrx200a2x-gphy";
>> +			reg =3D <0x68 0x4>;
>> +
>> +			resets =3D <&reset0 29 28>, <&reset1 6 6>;
>> +			reset-names =3D "gphy", "gphy2";
>> +			lantiq,gphy-mode =3D <GPHY_MODE_GE>;
>> +		};
>> +
>> +		reset0: reset-controller@0 {
>=20
> ...@10

done


>> +			compatible =3D "lantiq,xrx200-reset";
>> +
>> +			offset-set =3D <0x10>;
>> +			offset-status =3D <0x14>;
>=20
> reg =3D <0x10 8>;

done

>> +			#reset-cells =3D <2>;
>> +		};
>> +
>> +		reset1: reset-controller@1 {
>> +			compatible =3D "lantiq,xrx200-reset";
>> +
>> +			offset-set =3D <0x48>;
>> +			offset-status =3D <0x24>;
>=20
> reg =3D <0x48 4>, <0x24 4>;

done

>> +			#reset-cells =3D <2>;
>> +		};
>> +
>> +		usb_phy0: usb2-phy@0 {
>> +			compatible =3D "lantiq,xrx200-usb2-phy";
>> +			status =3D "disabled";
>> +
>> +			regmap =3D <&rcu0>;
>=20
> This should be dropped.

I will get this from the parent device now.

>> +			offset-phy =3D <0x18>;
>> +			offset-ana =3D <0x38>;
>=20
> Use reg.

There is also one bit used to reset the DSL digital frontend at offset
0x38. This has nothing to do with USB.

>> +			resets =3D <&reset1 4 4>, <&reset0 4 4>;
>> +			reset-names =3D "phy", "ctrl";
>> +			#phy-cells =3D <0>;
>> +		};
>> +
>> +		usb_phy1: usb2-phy@1 {
>> +			compatible =3D "lantiq,xrx200-usb2-phy";
>> +			status =3D "disabled";
>> +
>> +			regmap =3D <&rcu0>;
>=20
> Drop.

done

>> +			offset-phy =3D <0x34>;
>> +			offset-ana =3D <0x3C>;
>=20
> Use reg.

There is also a bits to configure something with the DSL dying gasp at
offset 0x34. This has nothing to do with USB.

>=20
>> +			resets =3D <&reset1 5 4>, <&reset0 4 4>;
>> +			reset-names =3D "phy", "ctrl";
>> +			#phy-cells =3D <0>;
>> +		};
>> +
>> +		reboot {
>> +			compatible =3D "syscon-reboot";
>> +
>> +			regmap =3D <&rcu0>;
>=20
> Drop.

The syscon-reboot driver uses this code to get the regmap:
ctx->map =3D syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
This driver was not added by me.

>> +			offset =3D <0x10>;
>> +			mask =3D <0x40000000>;
>> +		};
>> +	};
>> +
>> --=20
>> 2.11.0
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
