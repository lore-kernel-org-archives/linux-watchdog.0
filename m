Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE934F24A;
	Wed, 13 May 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696855; cv=none; b=ERoryjCLD64Z6JVRtL5NVP94SGlow70fa+nFf5wV59WT+5ZEYI3nDqUqhkUag2B9AWGyVpNZ/L2I1hn5IhLfMqkcl6F3AyUtxrVeuuv7q1BC71nBlKn/zxmBhSzZSdRHI55OY32grlqYcKBckp3AMXcnRzQcV4s/9YweW6FgZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696855; c=relaxed/simple;
	bh=U+gpFN+RSsUwbf9M7/OCLx+9/4EfQ7T+fmphEOEvUeQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NcqlbtZQ8Cum0ThOhuq5dYvoODNByTZcBhbO3zv7lkxhkick3B0VfINQDxZ38D7qFgJCe91n6nyCRAnedx9OR3Wk4g0CNUYx2+USVSoyjHmXGQtO6AZna+knYK9NMXxhoP3KHuyjD68+937Vacow5KfNORLwb9bEjzS+TM7Hkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=M7+anODz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="M7+anODz"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5406126726;
	Wed, 13 May 2026 20:27:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e86NvDpJYWQC; Wed, 13 May 2026 20:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778696850; bh=U+gpFN+RSsUwbf9M7/OCLx+9/4EfQ7T+fmphEOEvUeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M7+anODzISF9yOt+P/qo7mrd9V4aCS0IjDm4vI+gnXEAjbYYa1a8ZodzWb4ZYpqQm
	 jDCR/IyjiVa8i1WDBday46Bh+cnan9VkNxErbSYviYjQipySLecA9gDrANAwy7rVEy
	 b0/nvfMe47yFhbMOG9+S5eTz4pl82qXeo4xpoSWQQrw9+NkLcWOCiOtipvY66PgJUp
	 QBMsfmmTZ1SPfTWWHq0m13TID2O4wUnaPjlRnMDB4U1W9O4tz2oLfWiQ9zwtpbfksZ
	 dhFY/+/VWK0JXNY6l3p92O1UC7wvXLtgjB/Fx3SVDjm2rU+341XHQnPQ46DoyR6+7w
	 rGnOkcCSt7UGg==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 18:27:30 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Sander Vanheule <sander@svanheule.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: realtek,otto-wdt: add
 compatible for RTL9607C
In-Reply-To: <20260511-alienate-guidable-d503194e6a93@spud>
References: <20260509163101.722793-1-adilov@disroot.org>
 <20260509163101.722793-3-adilov@disroot.org>
 <20260509-rebuild-snowboard-e82a3adc5a27@spud>
 <94a75930847c2b7a221736c41a1da67d@disroot.org>
 <20260511-alienate-guidable-d503194e6a93@spud>
Message-ID: <3f4970d318c0f0aa930510626ff6445c@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-05-11 15:52, Conor Dooley wrote:
> On Sun, May 10, 2026 at 08:19:09AM +0000, Rustam Adilov wrote:
>> Hello,
>> On 2026-05-09 18:13, Conor Dooley wrote:
>> > On Sat, May 09, 2026 at 09:31:00PM +0500, Rustam Adilov wrote:
>> >> Add the realtek,rtl9607-wdt compatible to the Realtek Otto watchdog
>> >> binding.
>> >>
>> >> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>> >> ---
>> >>  Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
>> >> index 1f5390a67cdb..ac9db40b12dc 100644
>> >> --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
>> >> +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
>> >> @@ -30,6 +30,7 @@ properties:
>> >>        - realtek,rtl8390-wdt
>> >>        - realtek,rtl9300-wdt
>> >>        - realtek,rtl9310-wdt
>> >> +      - realtek,rtl9607-wdt
>> >
>> > Please explain in your commit message why this new device is not
>> > compatible with the existing ones, particularly given the driver patch
>> > implies that it would be.
>> > pw-bot: changes-requested
>> 
>> Is the fact "RTL9607C is different SoC compared to the others in the list" not
>> enough of a reason to include even though the all of them have an identical watchdog
>> timer device? But yes, i can use any other compatible just as fine.
> 
> No. And to be clear, I'm not asking you to use one of the other
> compatibles. I'm asking you to use one of the existing ones as a
> fallback.

Okay, I see. Thanks for explanation. Sander is currently going over adding a proper
fallback compatible. In the meantime, i can drop the patches 2 and 3 for v2 of this
patch series as they are no longer necessary.
