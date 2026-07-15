Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF448BD27;
	Wed, 15 Jul 2026 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131196; cv=none; b=XipapQ5Qn+sUAGlCJ0Ww5yXWRMAiBvivAK9rypo+gmPxQWTB3Nh/WeOQ1Iuak7thV+XDJq71tfJVj1ambN6x9xMK/7Xhr38Ot0qYkfs7/mOSI4s0zGSNniO2hHHEcprA9x5BL9HkK1m/YPfhm3plL9MNSaczvjH3G180peUaotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131196; c=relaxed/simple;
	bh=bnezhdfIEjttCekTAw0vG3iuJhH/Y0Y3BK6tdMGVugk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFd8IrL1W3jdiS7OVFslVSvmLAIOAtjwsr8sLkgLGVE44Eg1bPyeA6caUP8JnfjHtXALRwVo8EW4Z7yHFPrDKRN7iYI0tS1OvJvV5R0CVHll/AvsZ1pDkmdm0TZPhuZ25BIzSP7uFqG6feecAVzYSHTw5qYx8l7EMEENJxGTo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+uYLfKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+uYLfKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5971F1F000E9;
	Wed, 15 Jul 2026 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131195;
	bh=N+qVwV2aNltYFdxx/9mvVwz5Hq1QR+apcslhNzwT5x0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V+uYLfKrlDGoRE018a/ACM72eQ//ba/OxJxjMN+blpaRXH5vj+QPK/MWIKI7wF6DV
	 JvqLQf/7seBAaUE4aKlC61cJjenMDGkJI9vTW46OYXS9O2lhlLdZ3r9o1+5MZz3N4A
	 fMIaUUg7xMuXFZjS8u5Na1cjqthXymyVev0vfR5of0o8w3X8F64AvFPy3P5lhtLrRV
	 Zng2+as+VzSKGmP1Wt3r7acB6aFmKMyQW5DcDMyxchEXb5uK5beVW4nZICqa6kCAl6
	 vDecircMkneRozZgJ1uMdP7C4QHnuI0OD7Pja8vPGTrTIv+Zx4tXvsx8Nfwo8eyaPl
	 XxfT2iHuYXciQ==
Message-ID: <f8ff669d-da2c-4560-ac7c-617b18c41177@kernel.org>
Date: Wed, 15 Jul 2026 17:59:49 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Initial Apple M3 Pro, Max and Ultra device trees
To: Guenter Roeck <linux@roeck-us.net>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Andi Shyti
 <andi.shyti@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <c2bbbd1a-a188-41f0-8225-65ca52ee3afe@roeck-us.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <c2bbbd1a-a188-41f0-8225-65ca52ee3afe@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/15/26 17:55, Guenter Roeck wrote:
> On 7/15/26 02:11, Janne Grunau wrote:
>> This series adds device trees for Apple silicon devices with M3 Pro, Max
>> and Ultra SoCs. The M3 generation has fewer devices than their M1 and M2
>> predecessors. The only non-laptop device is the M3 Ultra Mac Studio. The
>> Laptops are the known 14 and 16-inch Macbook Pros now with M3 Pro and
>> M3 Max SoCs. The M3 Max variant with fewer CPU and GPU cores has
>> additionally only a 384-bit wide memory bus instead of 512-bit of the
>> full M3 Max. It has a separate identifier (T6034) and so there are six
>> laptop device trees.
>> Another difference to M1 and M2 Pro/Max/Ultra is that the M3 Pro is
>> distinct SoC design and not a smaller M3 Max. For this reason both M3
>> Max variants and the M3 Ultra will use "apple,t6030" as compatible
>> prefix. In the M1 and M2 generations Pro, Max and Ultra SoCs shared
>> "apple,t6000" / "apple,t6020" as common prefix. There is currently no
>> known difference but M3 Pro and M3 Max are not as closely related as
>> previously.
>>
>> This series adds the same level of hardware as the base M3 (T8122) has
>> in v7.2-rc1. This includes CPU cores, interrupt controller, power
>> states, watchdog, serial, pin controller, i2c and the boot framebuffer.
>> This is intended as base so that support for additional hardware can be
>> added to all M3 based devices at the same time.
>>
>> Merge strategy:
>> Since the dt-binding add new compatible strings without driver changes
>> it would be preferred if the whole [1] series would be merged through
>> apple-soc/arm-soc. This will help ensuring a warning free
>> `make dtbs_check` for followup series with additional M3* hardware
>> support I hope to send for this cycle.
>>
>> This series will conflict with the M4 series [3] sent A couple of days
>> ago. I would prefer if this could be merged first (in order of SoC
>> release).
>>
>> [1]: I see that the M4 watchdog change was already picked up by Guenter
>>       in [2]
>>
>
> Whatever one does with individual patches in such series seems to be
> wrong. Are you saying that I should drop the M4 (t8132) patch from
> the watchdog-next branch ?

Feel free to keep it. I'll just pick up everything that's left once this 
series is ready and make sure there are no duplicate patches in -next.


Sven


