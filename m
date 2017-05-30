Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52574 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbdE3WCt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 18:02:49 -0400
Subject: Re: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-9-hauke@hauke-m.de>
 <CAHp75VcU3cF07GQG5vPV9uhmpOzO2aGD8Fj9-Do4yN3BXNN1Rg@mail.gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <6d18d1d4-b69c-70dd-f64e-2209685fe360@hauke-m.de>
Date: Wed, 31 May 2017 00:02:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU3cF07GQG5vPV9uhmpOzO2aGD8Fj9-Do4yN3BXNN1Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 08:23 PM, Andy Shevchenko wrote:
> On Sun, May 28, 2017 at 9:39 PM, Hauke Mehrtens <hauke@hauke-m.de> wrot=
e:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> Instead of hacking the configuration of the FPI bus into the arch code
>> add an own bus driver for this internal bus. The FPI bus is the main
>> bus of the SoC. This bus driver makes sure the bus is configured
>> correctly before the child drivers are getting initialized. This drive=
r
>> will probably also be used on different SoC later.
>=20
>> +Optional properties:
>> +- regmap               : A phandle to the RCU syscon
>=20
>> +- offset-endianness    : Offset of the endianness configuration regis=
ter
>=20
> Shouldn't be one of
>=20
> big-endian;
> little-endian;
> native-endian;
>=20
> ?

The offset-endianness is the offset of the endianes register in the RCU
register range which is accessed through the syscon. For the SoCs where
I checked it is the same value. I should add a documentation of big-endia=
n.

> For what purpose that register is used?
> Is it configurable in RTL? IOW why you need to have it in DT?
>=20
>> +               offset-endianness =3D <0x4c>;
>> +               big-endian;
>=20
>> +       /* RCU configuration is optional */
>> +       rcu_regmap =3D syscon_regmap_lookup_by_phandle(np, "regmap");
>=20
>> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {
>=20
> _OR_NULL is suspicious. You are doing something wrong.
>=20

This is only needed for some SoCs, some chips do not have this register.
Should I do this based on the compatibility string?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
