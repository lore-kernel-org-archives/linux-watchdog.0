Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA537DE9D;
	Sun,  5 Jul 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259097; cv=none; b=hjyqokCl+fAaMBCHnL3RjuJhH6P9rBF/1C0J5ZUUguvqgp+8c67dS6HHU7Y4O/Ox6G05mnmxsJR5BYWTilryAEcKCMneL7yvpuVRiC2dgaV4ynQMzV5in3Isr3nM/JZMLadszq4hyNikCVcuX+Fgf6xOO6t8UR9PfHKX6utr98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259097; c=relaxed/simple;
	bh=QY+6SuFq9pvYzlSwRTSIY5NiTd9xneHei3mgY5TAmz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+0FLYsCV3x4CvAy1qWSpPKcg7Xj8qy+Oum9MFYdC0HukDhKmiHtc3P6K0W+c+kxl1VRqECFtOOWFyFOTcRN3u3K7wqy6Nd1rQiEwpx4/WSFKjq+9JzdjoUyjYL/Lxl2V6OozCz+xl9IoFsIyPsevDyFaKtALZi/wALUkTER6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=sOIZbYIF; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="sOIZbYIF"
Message-ID: <0df7860e-a3c9-466c-8003-f751d48b5465@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1783259093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3SH4Fc8GRkJNGIuSVNSHqcQJgONWwp41Z6E55XKFFc=;
	b=sOIZbYIFGckCBR6J4qYtPkNx2lEzfgR0JiJyIJo6grofQ3gi3058JKig9L+ZnCYJKS2E8V
	pd//lLEdfetx8fBzv7YT3Z+iYrmpOO5coivQrUSYuG3aUkn+cQ6vK0zzvvSQCPXPYa1fcR
	OSv0L59LGg1tyi3oF8mMCCSY/1C1P8g=
Date: Sun, 5 Jul 2026 15:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] arm64: dts: apple: Add minimal t8132 (M4) device
 trees
To: sashiko-reviews@lists.linux.dev, Yureka Lilian <yureka@cyberchaos.dev>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 linux-watchdog@vger.kernel.org
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-10-e5655ee56523@cyberchaos.dev>
 <20260705132808.82D2B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20260705132808.82D2B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/26 15:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The `aic` node has a mismatched unit address and overlapping memory regions in its `reg` property.
> - [Low] The `model` property for the MacBook Air (13-inch) erroneously declares the year as 2024 instead of 2025.
> - [Low] `t8132` device trees are incorrectly placed at the very top of the `Makefile`, breaking the chronological sorting order.
> --
>
> commit 281d92c4ca5eb8a2224c6bb0b9116c7518b422d1
> Author: Yureka Lilian <yureka@cyberchaos.dev>
>
> arm64: dts: apple: Add minimal t8132 (M4) device trees
>
> This commit adds minimal device trees for a series of new Apple M4 devices,
> including MacBook Pros, MacBook Airs, iMacs, and the Mac mini. The device
> trees are limited to essential components like CPU cores, interrupts, and
> serial, allowing a basic boot. It also notes that SMP support currently
> remains unreliable.
>
>> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
>> index 6fc3349a58428..181bd0e289653 100644
>> --- a/arch/arm64/boot/dts/apple/Makefile
>> +++ b/arch/arm64/boot/dts/apple/Makefile
>> @@ -1,4 +1,10 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j604.dtb
>> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j623.dtb
>> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j624.dtb
>> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j713.dtb
>> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j715.dtb
>> +dtb-$(CONFIG_ARCH_APPLE) += t8132-j773g.dtb
>>   dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j71.dtb
> [Severity: Low]
> This isn't a bug, but should these new t8132 device trees be appended
> to the bottom of the list rather than prepended at the top, to maintain
> chronological sorting order in the Makefile?
I had this at the top to make rebasing easier, but for the upstream 
version it should be at the bottom. Changed locally.
>
> [ ... ]
>
>> diff --git a/arch/arm64/boot/dts/apple/t8132-j713.dts b/arch/arm64/boot/dts/apple/t8132-j713.dts
>> index 0000000000000..b1f779c37d5fe
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/apple/t8132-j713.dts
> [ ... ]
>> +/ {
>> +	compatible = "apple,j713", "apple,t8132", "apple,arm-platform";
>> +	model = "Apple MacBook Air (13-inch, M4, 2024)";
> [Severity: Low]
> This isn't a bug, but does the model string contain a typo? The header
> comment for this file identifies the target as a 2025 model, but the model
> string exposes 2024 to userspace.
Typo. Fixed for v2.
>
> [ ... ]
>
>> diff --git a/arch/arm64/boot/dts/apple/t8132.dtsi b/arch/arm64/boot/dts/apple/t8132.dtsi
>> index 0000000000000..715980b5c7de4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/apple/t8132.dtsi
> [ ... ]
>> +		aic: interrupt-controller@381180000 {
>> +			compatible = "apple,t8132-aic3", "apple,t8122-aic3";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			reg = <0x00000003 0x81000000 0x00000000 0x1cc000>,
>> +			      <0x00000003 0x81040000 0x00000000 0x4000>;
> [Severity: Medium]
> Is the base address and memory region mapping for aic intentional?
>
> The node defines a unit address of @381180000, but the reg property specifies
> a base of 0x81000000 (translating to 0x381000000). Also, the first memory
> region of size 0x1cc000 completely overlaps the second region starting at
> 0x81040000.
>
> Could this typo in the physical address map explain the unreliable smp boot
> behavior mentioned in the commit message?

I believe the core and event regs overlapping is correct. The same 
overlap exists in t8122, and also in downstream Asahi t6030/t6031 dts.

>
