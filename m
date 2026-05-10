Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C49355F3A;
	Sun, 10 May 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401154; cv=none; b=ihGsHK5MsJdk/MZSEnTnXTFO3HL3oScoxeTI8pOcPL0aQxZXV9KMGe4SZQLCbdv0JI2OblNxDIX8MFr/vVSlsmP1/30Bxhw0b2l88z6d3rRZa9OdRvdiQ9BwZFJnOoyhP70yyCsD1/NlGh3o0aX6YHfavWjWpN1FS33Pi4v1mEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401154; c=relaxed/simple;
	bh=Rsr2uoT1D7OE6kRAfk4ca1Y1p5nq2ZlX7e2NNPLAqb0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dwpL+TPzhSBCT69+oDQ+jzooL2kPkywSoFMeCnOLo2GrLUi3BTlpi1kYQYkX+GwlaU1+JcS03KxxvM7Hce5OCHMAGci5uVSOB0YaUAZeyZrUplyeRn7YDf6j6r1IoEoNznQFZnZyoYuKgB92R7pELyYZ0hIstxWtbNtSfSvkgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VqAJiWH8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VqAJiWH8"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1FBBA27198;
	Sun, 10 May 2026 10:19:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CP4UHbp1POA2; Sun, 10 May 2026 10:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778401149; bh=Rsr2uoT1D7OE6kRAfk4ca1Y1p5nq2ZlX7e2NNPLAqb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VqAJiWH8GnpIrbE+UmXj0qrG6Hs+TwDnVBi7Vx2fnr2yg8mgL17oCy+2I1dt/zBqu
	 /oj6DioPThBv9rLQXkiItzNAqd0FOG+R67jUJ6IEpOyj6OfahixpCaX+7jRvzCsBWm
	 0zO9vpWfZPhyvzJ1JsvYipLTh8BJV4azGeI1tAM3VBXaUTLmMleQYG24Q7zfXVhiAS
	 dQsGMCg3kwhwAa4S4Ur7ufo5stMTYNL9mLY5qhNI3Yp/qx5Iyv8X5EWC49MMOzMrY4
	 a/snqiUv1lgNMKR6xxtaKjfE8ZR2O6ggHp6vHRry+UjBDx3sPJFwL6M/Yp6OSQtLsx
	 VlWkNDVeprvbg==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 10 May 2026 08:19:09 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Sander Vanheule <sander@svanheule.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: realtek,otto-wdt: add
 compatible for RTL9607C
In-Reply-To: <20260509-rebuild-snowboard-e82a3adc5a27@spud>
References: <20260509163101.722793-1-adilov@disroot.org>
 <20260509163101.722793-3-adilov@disroot.org>
 <20260509-rebuild-snowboard-e82a3adc5a27@spud>
Message-ID: <94a75930847c2b7a221736c41a1da67d@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,
On 2026-05-09 18:13, Conor Dooley wrote:
> On Sat, May 09, 2026 at 09:31:00PM +0500, Rustam Adilov wrote:
>> Add the realtek,rtl9607-wdt compatible to the Realtek Otto watchdog
>> binding.
>> 
>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>> ---
>>  Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
>> index 1f5390a67cdb..ac9db40b12dc 100644
>> --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
>> +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
>> @@ -30,6 +30,7 @@ properties:
>>        - realtek,rtl8390-wdt
>>        - realtek,rtl9300-wdt
>>        - realtek,rtl9310-wdt
>> +      - realtek,rtl9607-wdt
> 
> Please explain in your commit message why this new device is not
> compatible with the existing ones, particularly given the driver patch
> implies that it would be.
> pw-bot: changes-requested

Is the fact "RTL9607C is different SoC compared to the others in the list" not
enough of a reason to include even though the all of them have an identical watchdog
timer device? But yes, i can use any other compatible just as fine.

Maybe its just difference in maintainers because the RTL9310 [1] was accepted and
had the identical case to this one.

[1]- https://lore.kernel.org/linux-watchdog/84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net/

> 
> Thanks,
> Conor.

Best,
Rustam
