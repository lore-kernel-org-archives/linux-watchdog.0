Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6B8E;
	Mon, 11 Dec 2023 08:58:04 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 85DF47FD3;
	Tue, 12 Dec 2023 00:58:03 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 00:58:03 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 00:57:58 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: <krzysztof.kozlowski@linaro.org>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<jisheng.teoh@starfivetech.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<samin.guo@starfivetech.com>, <wim@linux-watchdog.org>,
	<xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date: Tue, 12 Dec 2023 00:57:31 +0800
Message-ID: <20231211165731.1604004-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3b53b6c4-96e6-4129-912e-82b8ab9b2269@linaro.org>
References: <3b53b6c4-96e6-4129-912e-82b8ab9b2269@linaro.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 11:06:09 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 09/12/2023 15:27, Ji Sheng Teoh wrote:
> > Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> > watchdog.
> > Since JH8100 watchdog only has 1 reset signal, update binding
> > document to support one reset for "starfive,jh8100-wdt" compatible.
> >=20
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> >  .../watchdog/starfive,jh7100-wdt.yaml         | 29
> > ++++++++++++++----- 1 file changed, 21 insertions(+), 8 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > index 68f3f6fd08a6..eec182317219 100644 ---
> > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > +++
> > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > @@ -19,14 +19,12 @@ description: isn't cleared, the watchdog will
> > reset the system unless the watchdog reset is disabled. -allOf:
> > -  - $ref: watchdog.yaml#
> > -
> >  properties:
> >    compatible:
> >      enum:
> >        - starfive,jh7100-wdt
> >        - starfive,jh7110-wdt
> > +      - starfive,jh8100-wdt
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -44,11 +42,6 @@ properties:
> >        - const: apb
> >        - const: core
> > =20
> > -  resets: =20
>=20
> No, keep it here with min/maxItems.
>=20

Ok, will change it up to use min/maxItems.

> > -    items:
> > -      - description: APB reset
> > -      - description: Core reset
> > -
> >  required:
> >    - compatible
> >    - reg
> > @@ -56,6 +49,26 @@ required:
> >    - clock-names
> >    - resets
> > =20
> > +allOf:
> > +  - $ref: watchdog.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - starfive,jh8100-wdt
> > +    then:
> > +      properties:
> > +        resets:
> > +          items:
> > +            - description: Watchdog reset =20
>=20
> Why is it called "Watchdog"? How is it different from "Core"?

Will standardize them to use "Core" instead. Thanks.

>=20
> Best regards,
> Krzysztof
>=20
