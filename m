Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D85399CEE;
	Fri, 17 Jul 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279826; cv=none; b=j5cyxhgyKAieXS9z4UZurooYGgDuwmsqWytT9fKEDHxpetsdRXk/EMybmhw3R/PwI6duGtU6z5LlSkmJ4MwzG2AZOyLXB3XmnBG/19nTUIsnd18bF7hO0d77kvQexcE+zPbYXGHcuQuLpWT2c9sKRQQIvMjmo4epRaslxkBVh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279826; c=relaxed/simple;
	bh=8NOZBHoiBki1nYBte5Bsg6biVgb+C3gvMFTiUF58j0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+1AOprSO2n+f7Sio25023cgo10KMWoSMds/OTfOXHKejAoYz6qouWgB9w2sTF1GFjEjEbQel1vqnopGHiEp388oY3OtGszE6wJtoT9tO4NpsaAjjII1Zzk3jSUjwDGP6P0ZUWLTEtYbM1qctViwfbk0E9V9ALDJLOCuoHn2V9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=p0YeJ7J5; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="p0YeJ7J5"
Message-ID: <5439c27a-84c9-455d-9c2d-be84a37469fe@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1784279814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHnjMIAGRm2ejsywkpInpP3dH/N1dPQydtPOOeL+IoE=;
	b=p0YeJ7J5SHfYAAl34NLbf0yPli175elPbpLSRPmFGKTsrMkQgqwBQvdM1sVdP1rjJIYQQS
	iEld3eWbyM4t71a0BQ7o2xqdyxD2oMSj1nqb7Q+AjfIcdtqxtIaEQr/0yoA3mWbYj88keW
	Z4cbd3/7xkEdcCsUnyiUu1Zsug2+9c0=
Date: Fri, 17 Jul 2026 11:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 08/10] dt-bindings: pwm: apple,s5l-fpwm: Add t8132
 compatible
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Thomas Gleixner <tglx@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>,
 Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-8-e5655ee56523@cyberchaos.dev>
 <alj0EbuIzZUa48di@monoceros>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <alj0EbuIzZUa48di@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/16/26 17:11, Uwe Kleine-König wrote:
> Hello,
>
> On Sun, Jul 05, 2026 at 03:17:27PM +0200, Yureka Lilian wrote:
>> The PWM controller on the Apple silicon t8132 (M4) SoC is compatible
>> with the existing driver. Add "apple,t8132-fpwm" as SoC specific
>> compatible under "apple,s5l-fpwm" used by the driver.
>>
>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>> ---
>>   Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
>> index 25ef04b60ca1..c85a2b85a66a 100644
>> --- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
>> @@ -19,6 +19,7 @@ properties:
>>             - apple,t8103-fpwm
>>             - apple,t8112-fpwm
>>             - apple,t8122-fpwm
>> +          - apple,t8132-fpwm
>>             - apple,t6000-fpwm
>>             - apple,t6020-fpwm
>>         - const: apple,s5l-fpwm
> There is no merge plan specified in the cover letter, but I assume this
> should go via arm-soc?

Yes, this will go through the appropriate -soc trees since there is no 
driver change.
Sorry for not mentioning it in the original cover letter, I wasn't aware 
of the procedures at the time.

>   In that case:
>
> Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
>
> Best regards
> Uwe


Thanks,

— Yureka

