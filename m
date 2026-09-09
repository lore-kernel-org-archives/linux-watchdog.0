Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C183AD518;
	Wed,  9 Sep 2026 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939302; cv=none; b=C1r/7DRlaFmr+HFfWJjMcAfA4Mc2axQTTgicIJAe7pLXvwWJBmPEMo5TBdWLuVAFMD1c+LozN+0t2bpzJvC/zn/wLxGE3r3DcxIJQpECMYv9asBNMBhaTfLo/NBcqhx719zDL+HuofmI/qb9ZA3x+IkxgnCON06qmJIDI0Kycas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939302; c=relaxed/simple;
	bh=GfxKyBaoyH40ew/NzikCqRTPnYe0Nah/k/DFGQ43UcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/p6dJougVnvrRhkfbbulPhmUJpSpsFS2SsCm/KzvCvxrDpyKlm/aDBI5yOuqeLyO5tlHq4vEcZmq73uL4bx7Z3Let2KrZuPlQ+oTfJHbyj4SfI6OdNMpIF8wNDHKrbl+o7DTbVpOkziyqEEFUd/ZtpT2y+9kUKRCZcqmOrAhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=cHFRKjSc; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="cHFRKjSc"
Message-ID: <76d1c5c8-f051-4365-b113-e18be5aaa9a0@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1788939287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgZ0tWkgjiEUeT5VerSLaz3Hth8Pz9PPnVSIhaTxQI8=;
	b=cHFRKjScczQSvT5fk2vci/k6J/UV5FTWYurvqzFFWVUn1fA2Kh5oWSI+1YO961ZY1/IpSr
	ejRHJtV2AjhqFNRjv/Lni2aKJYWsvSIxKs8f2pplBh2bm7cHSUzzkoOkBcZ/Yi8ScqrgDH
	zcWIzhxf9XQ0eOliYI5xsUMfBiN7f8Q=
Date: Wed, 9 Sep 2026 09:34:43 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t8140 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-4-0c25401d165d@cyberchaos.dev>
 <4e65ef39-cf1b-49d4-a899-da36acb442c2@gmail.com>
 <20260909-advanced-marble-lorikeet-eebeef@quoll>
 <76ad4ffe-82b8-42ec-abbe-a8c35ed8705f@kernel.org>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <76ad4ffe-82b8-42ec-abbe-a8c35ed8705f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/9/26 09:32, Krzysztof Kozlowski wrote:
> On 09/09/2026 09:31, Krzysztof Kozlowski wrote:
>> On Sat, Sep 05, 2026 at 04:25:36PM +0800, Nick Chan wrote:
>>> Yureka Lilian 於 2026/9/5 凌晨3:49 寫道:
>>>> The Apple t8140 (A18 Pro) SoC uses an AIC3 as interrupt controller, same as
>>>> the M1-M4 SoCs.
>>>>
>>>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>>>> ---
>>>>   Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
>>>> index 1cb886785173..e3cadc5ad39d 100644
>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
>>>> @@ -46,6 +46,7 @@ properties:
>>>>                 - apple,t6030-aic3
>>>>                 - apple,t6031-aic3
>>>>                 - apple,t8132-aic3
>>>> +              - apple,t8140-aic3
>>> the title should be "... Add t8140 compatible" describing the hardware corresponding
>>> to the added compatible since the compatible being added is not "apple,t8140".
>> Commit msg is correct, it does exactly what you wrote, no?
>>
>>> (Alternatively, if you mention the compatible in title, say "...Add apple,t8140-aic3" as
>>> "compatible" is already implied)
>> That would be repeating diff, so not really helpful.
>
> Ah, you meant the subject of the patch...
>
>
> Best regards,
> Krzysztof


That's how I parsed it too. Removed the "apple," from the subject, so 
it's just "dt-bindings: interrupt-controller: apple,aic2: Add t8140 
compatible".


- Yureka

