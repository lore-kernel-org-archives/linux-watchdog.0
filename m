Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367381;
	b=R8ulxBTLLw6zHOiT5qWys0PADaUkW305pk9u8f0CftrgKsUixafWxDtoWoH7hxiAQ4Vu
	 5PrxLhSKBN8ubK8LvUVPXW0Ty5UcFloeo4y/YLM/YAY9nh1MIPspWtmbGq2YHRXbrCpbH
	 okdWRfTbXUYkrZtHPDmTm73WyEejAQkNujW+hCtQ70bSBBhh2mwtX8uTIZc3LYm6sZ7nP
	 5a+3TCPB6gYPb3m7dKYJXAymp+ljwyk7CzXRzRViO/6CM/BIckdZC698hRKu1iKY5kRSs
	 KoaX+fJ6Yu8e4+wObpqa6ns+okMiwkQDssSMXk+rZ1/KwjV+Jg9k4DQe2heAW/GWXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367381;
	h=DMARC-Filter:DKIM-Signature:User-Agent:X-Lms-Return-Path:To:Date:
	 Mime-Version:Received:Content-Transfer-Encoding:Cc:From:Content-Type:
	 Subject:Message-Id:X-Original-From:References:In-Reply-To;
	bh=cwlQpXqaLUwHvZtTs8DVVBeTiYBaieNwyzTfHe3g38c=;
	b=d7jRdwLbgTbEaNcAOo+Qj13Ehp6NJKAWS6ofnPY8j8kcMs5PIDe5JbWQZtp+Pg0UnTTw
	 e0W/bA6GKUp8pCey1KylMn+ab0PDeK+0aXzSc5vsGhYg9qxqoZieH50WdAzIvvQIJblcK
	 3R92AndPlKdlXiIC1M2q4elY5fpSSFeFbEdqcabANDw6VC/gY9pDw2RDqWinMnOkGReHc
	 qPImaQ/Ro0UYbAUyugNLJLRNQoXRogFyOf8GcYO7d93pSm9TWiANAaH4Fck1BZSjboLof
	 7fobP0CVzZEU6ZFnw//xuFKWmb6ugiYLrIe5ArtPB0x24nErxf19AuyJFYfg45iDJ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=QdU2PjN+;
	arc=none smtp.remote-ip=209.127.231.47
Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B4606A326
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 03:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F4B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=QdU2PjN+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794367374;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cwlQpXqaLUwHvZtTs8DVVBeTiYBaieNwyzTfHe3g38c=;
 b=QdU2PjN+S8MHyDoR8BoIIAvVmAtOsi8yx0EEPS4BkrbIqArHI0gSgae+o14zTNcsbmpG5H
 /Csdzuo+Izi/Verz7pp/S5R6kx6kzDGfOV6WaySoPq2zDWt3GVjltOq3CXwCj6Tsxkp0C6
 XsceqzKhlqwNXqfLD99X8mSwVaVQ6BiMDz8Q2bpGV3fl16+Quzlog6Kb79V2k1MlgMV98b
 sgI4dTeE0yVi6bDoxbnRpQm8+w9+6fZjbyRy1K4MYWzLvbtZPCYl1uZipL88OdzdkaIDVe
 5irPPHFNWgpECodUkwmOuivz42dCQxJeXbUgFer3cWijbByB43QGc2AMHOUyzw==
User-Agent: Evolution 3.62.1-3
X-Lms-Return-Path: <lba+26af3df8c+79df59+vger.kernel.org+rongrong@oss.cipunited.com>
To: "Conor Dooley" <conor@kernel.org>
Date: Wed, 11 Nov 2026 11:17:48 +0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [192.168.8.156] ([1.192.71.23]) by smtp.feishu.cn with ESMTPS; Wed, 11 Nov 2026 11:22:51 +0800
Content-Transfer-Encoding: 7bit
Cc: "Rong Zhang" <i@rong.moe>, "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: loongson,ls1x-wdt: Add ls7a-wdt compatible
Message-Id: <227eb9a3dd5c1cb1af4cfbf2c94f30db1755a5d6.camel@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com> <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com> <20261110-barterer-pandemic-e4c658cac7c4@spud>
In-Reply-To: <20261110-barterer-pandemic-e4c658cac7c4@spud>

Hi Conor,

Thanks for the review.

On Tue, 2026-11-10 at 18:58 +0000, Conor Dooley wrote:
> On Tue, Nov 10, 2026 at 03:02:30PM +0800, Rong Zhang wrote:
> > The Loongson-7A has a watchdog, which is similar to Loongson 2K0300,
> > except that it has no clock controller.
> 
> I find this hard to believe, the device seems to be getting a clock from
> somewhere that the clock-frequency property is providing the rate of.

I must be losing my mind when I wrote this. My thought was "software
cannot control the clock" but my finger typed "no clock controller".

> 
> Why is that clock not represented in devicetree?

I will add a fixed-clock node in v2.

> 
> Confused,
> Conor.

Sorry for the confusion.

Thanks,
Rong

> 
> > 
> > Add "loongson,ls7a-wdt" compatible as well as a conditionally required
> > field clock-frequency.
> > 
> > Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> > ---
> >  .../bindings/watchdog/loongson,ls1x-wdt.yaml       | 31 +++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> > index 50a9b468c4a3..cb93e9578f82 100644
> > --- a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> > @@ -18,6 +18,7 @@ properties:
> >        - loongson,ls1b-wdt
> >        - loongson,ls1c-wdt
> >        - loongson,ls2k0300-wdt
> > +      - loongson,ls7a-wdt
> >  
> >    reg:
> >      maxItems: 1
> > @@ -25,13 +26,34 @@ properties:
> >    clocks:
> >      maxItems: 1
> >  
> > +  clock-frequency:
> > +    description: Frequency of clock in Hz
> > +
> >  required:
> >    - compatible
> >    - reg
> > -  - clocks
> >  
> >  unevaluatedProperties: false
> >  
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - loongson,ls7a-wdt
> > +
> > +then:
> > +  properties:
> > +    clocks: false
> > +  required:
> > +    - clock-frequency
> > +
> > +else:
> > +  properties:
> > +    clock-frequency: false
> > +  required:
> > +    - clocks
> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/clock/loongson,ls1x-clk.h>
> > @@ -41,3 +63,10 @@ examples:
> >  
> >          clocks = <&clkc LS1X_CLKID_APB>;
> >      };
> > +
> > +  - |
> > +    watchdog@100d0030 {
> > +        compatible = "loongson,ls7a-wdt";
> > +        reg = <0x100d0030 0xc>;
> > +        clock-frequency = <50000000>;
> > +    };
> > 
> > -- 
> > 2.55.0
