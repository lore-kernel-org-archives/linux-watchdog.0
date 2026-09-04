Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148736D4F1;
	Fri,  4 Sep 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555478; cv=none; b=YIISLnZoIBqEQQdkU7pCyxTKsFdH2KSBn7g01qz2a/iOCLJXG/XSbrlGm6p4BpsKag/aAY4MzDmCbvfd8oT+g4zB8L4oCa3XX0KWjX407TBIPp5DG7hsixpR+k2cFFdNYjzzSHTQwJNVxSg0G6qw2rNkux9bwQ9jh0/JvnhNsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555478; c=relaxed/simple;
	bh=/cG41PpS8GZOJXnrpQvgowAbf+PCE6ncyCVypBTIBtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDWfkT8JcdNFHSrVSdeTp7ZhmnTwWpEvFixWOu89dtUctGBQDujpM732BUr9rnZOWekDKrBM0XkH7hBTVOoVYxGfardz3LbXNqMZaKalNpWMRumhdhrrzCAL/EEPHDPgMeVvSvEYUMriUukPw+T761ASNShwBu+52+iLcVEKslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=35ve1kC0; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="35ve1kC0"
Message-ID: <859274b6-2863-4a6c-ad2c-bbb93b4c7f2b@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788555473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cG41PpS8GZOJXnrpQvgowAbf+PCE6ncyCVypBTIBtU=;
	b=35ve1kC0qvwCUrnDRVyTPjyaKPXXSLHYcmxuzog89DZwj7kaA1AWjilWt6qQxDq+TtRiN1
	hE8FgmNAP2ZtEO9EEg2NQmGM8qEihSuJIrA1mKGqnK6cdyBndoqpDO1g5QFj2vSXsk2Cyq
	xWDr1r3OpsGvbfDuJMSoWM6zpz/e/Bc=
Date: Fri, 4 Sep 2026 22:57:47 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] arm64: dts: apple: Add minimal MacBook Neo device
 tree
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
 <20260904-apple-a18-pro-initial-devicetrees-v1-6-0c25401d165d@cyberchaos.dev>
 <027b6019-9a2c-4f3a-8c64-c9836857b471@kernel.org>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <027b6019-9a2c-4f3a-8c64-c9836857b471@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/26 22:34, Sven Peter wrote:
> Hi,
>
>
> On 04.09.26 21:49, Yureka Lilian wrote:
>> Added a device tree for the MacBook Neo, which uses the t8140 SoC
>> (A18 Pro) also found in the iPhone 16 Pro.
>>
>> The device tree has a minimal set of devices limited to CPU cores,
>> interrupt controller, watchdog, serial and framebuffer.
>>
>> Using the macOS 26.6.2 iBoot/firmware, the machine reliably boots
>> on a single core using the stock kernel.
>> Booting with smp requires avoiding the wfi and wfit instructions
>> in the idle loop and `delay()` respectively, since those instructions
>> cause a loss of architectural state on the secondary cores.
>>
>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>
> [...]
>
>> +
>> +    memory@800000000 {
>
> this doesn't fit the reg you use below.
>
>> +        device_type = "memory";
>> +        reg = <0x100 0 0x2 0>; /* To be filled by loader */
>> +    };
>
> [....]
>
>> +
>> +        aic: interrupt-controller@301000000 {
>> +            compatible = "apple,t8140-aic3", "apple,t8122-aic3";
>> +            #interrupt-cells = <3>;
>> +            interrupt-controller;
>> +            reg = <0x00000003 0x01000000 0x00000000 0x1cc000>,
>> +                  <0x00000003 0x01040000 0x00000000 0x4000>;
>
> please be consistent and use 0x3 and 0x0 here like for the rest.
>
>
>
> Sven


Thanks for the review!

I've applied the suggestions to my branch.


- Yureka

