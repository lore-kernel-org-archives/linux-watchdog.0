Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1951E445;
	Fri,  4 Sep 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555306; cv=none; b=mU0jlOuPbZlqcNV9TzWCkR1otso42H2/tzOeHa8K7YTWh3e1XMsPXaeWrkAe8RKvlhef20+X5lR9Uc6S2atq2omLjT+cK6tX7umssCcK/UVoxK4yYIcANorkkFkso3/z8IY/Zno4iqgekHivfCxvI78MywAvVXafJzAGxpOz6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555306; c=relaxed/simple;
	bh=3O34s4vdtrOtaoj4CVplaq/PGJEFWOE4icIdXjEe1Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtUGegeyEcqvyaYXZfeOfcH9XdVknyC0wAnKq7YuKJ7IG9MisUtaIMRgJ6jeDks0HAuK1FogKUFsnoW7l+xAeIa0UlS/rUKfElIhLOSVtPp6fxNHdWJ4IZSFzjKih4986vfrLaR/Vrt1bcifoN8OSDZZ2Og3oaQ/pYxD43YIifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=4BNsxlYa; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="4BNsxlYa"
Message-ID: <3b46906d-8008-429c-a37a-f64ec72f865e@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788555300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAWyypjbQHQWLV/YSni14l1Mv0PCxp1TF5Y5nrSqlys=;
	b=4BNsxlYab9V10uKFF09vZeHyLlPxizM8wGth56loZ2yp6msysDffaEEcB5o2HAupWtld1z
	HAFQC+SlQrjKGap18I0+O0j2n+JwJmCLnPR5uB/TWOtrXySMcJd5Q2aXZf039Ddqm+4o+z
	ORzOAs2wOdyjR7Wj7pIAZNGHvMCsEFE=
Date: Fri, 4 Sep 2026 22:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] dt-bindings: arm: apple: apple,pmgr: Add t8140
 compatible
To: Sven Peter <sven@kernel.org>, Yureka Lilian <yureka@cyberchaos.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-2-0c25401d165d@cyberchaos.dev>
 <f73a94c4-80a7-41b0-9671-d9b6ea436174@kernel.org>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <f73a94c4-80a7-41b0-9671-d9b6ea436174@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/26 22:30, Sven Peter wrote:
> On 04.09.26 21:49, Yureka Lilian wrote:
>> The PMGR blocks on the Apple silicon A18 Pro SoC (t8140) is compatible
>> with the M1-M4 SoCs. Add "apple,t8140-pmgr" as A18 Pro specific
>> compatible.
>>
>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>> ---
>>   Documentation/devicetree/bindings/arm/apple.yaml            | 11 
>> +++++++++++
>>   Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
>
> There's something off with this commit, it's doing two things at once 
> and the description only mentions the smaller change.
>
> Sven


Good catch! I must have added one hunk too much while committing the 
change. Fixed locally / for v2.


Thanks,

- Yureka

