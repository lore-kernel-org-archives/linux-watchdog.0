Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0B384CDF;
	Fri, 15 May 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872481; cv=none; b=NCcDhU00k5pEnxIj2AjMuNMjQusdz31CagTUPTq9gwmiNFH6mYGI2aNjVRs7K0+43b+mcCdb//0sHjBkeebHGrY7YOE3fD5/Ewob6C7iTWxt0rgMsi0N3F/VeRgr49jgvB8a3HvIa9dG9ccZ7Qci8Emdcw/LPnD7CMR3kqCboVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872481; c=relaxed/simple;
	bh=N20JKR4L37TpqVbzx36TzdrkVwnBdNTzHv5ertLPX7M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nU7+QzboJ1EgBLtjIlldqTK6dUBtysZlA4B28TYjhdXd15UnqeQKSjv33dxkTyQVYXYPKYJBXX+kzNpyiOuC0nND/2l9/d8+fS1F9onymr5e9rlbWX0FGkEXo8MKP9EU0CwpuZzgjmYXjwM/VprZ2aSquLo2Q4Hh2DrdD5OJuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IMwYVyZp; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IMwYVyZp"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D31A5270C2;
	Fri, 15 May 2026 21:14:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67biAbKCMF2w; Fri, 15 May 2026 21:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778872477; bh=N20JKR4L37TpqVbzx36TzdrkVwnBdNTzHv5ertLPX7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IMwYVyZpqZhXQQ5YPdc7gQu0rA4cBeZm1XCdXmlxHvbjkPQiaOmluVm8iCYIF+4Rz
	 3XwpfqAXm7PlWHV1ZuEyCHQR0oGwdQiM9RHTXdoA4qZv7+RhtRvOMD2v8dBIlbOG9W
	 /HpCR7OOegkHfL+LLmkk43vE7MM/+hROfUd59zKErK24W8dNUoYAM+IB1MoURUY6sL
	 JumI2m+f6lvMZKAjZWx6rDHs16B+UhjMqSu/kDHTI8ZXZ5am1u+P5ejJsQU/Lacqn2
	 9nPBES/xFMZcGa4N30UK0J5dctAkwbeYUQcK+4H7pQhBIxUaR3Q+xRaWzpvHPklVCC
	 JsN7DTN6WMymw==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 19:14:36 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Rob Herring <robh@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] watchdog: realtek-otto: add fallback compatible
In-Reply-To: <55abfd54cc6f01cee65d54ec74754549e30e4a94.camel@svanheule.net>
References: <20260512204854.8931-1-sander@svanheule.net>
 <20260514161008.GB841147-robh@kernel.org>
 <9f81a947b65cafd44b293e05080b1fd2820cea06.camel@svanheule.net>
 <CAL_JsqLM4JQmbYCEz3-vpS+qiz8nXSk758CP_nFwWR2ihG-AFw@mail.gmail.com>
 <55abfd54cc6f01cee65d54ec74754549e30e4a94.camel@svanheule.net>
Message-ID: <d73e53888ab7d8541c5d84e733c04166@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Sander,
On 2026-05-15 08:47, Sander Vanheule wrote:
> Hi Rob,
> 
> On Thu, 2026-05-14 at 15:57 -0500, Rob Herring wrote:
>> On Thu, May 14, 2026 at 11:25 AM Sander Vanheule <sander@svanheule.net> wrote:
>> > 
>> > On Thu, 2026-05-14 at 11:10 -0500, Rob Herring wrote:
>> > > On Tue, May 12, 2026 at 10:48:52PM +0200, Sander Vanheule wrote:
>> > > > Like for the GPIO hardware of the Realtek Otto platform, add a fallback
>> > > > compatible for the watchdog hardware.
>> > > > 
>> > > > For backward compatibility, the binding will still allow current
>> > > > single-compatible devicetrees to work, but new devicetrees, including
>> > > > new compatibles, should use a two-component compatible.
>> > > > 
>> > > > This series serves to address comments regarding the device compatibles
>> > > > for the patches adding RTL9607C watchdog support [1].
>> > > > 
>> > > > [1]
>> > > > https://lore.kernel.org/lkml/20260509163101.722793-1-adilov@disroot.org/
>> > > 
>> > > You misunderstood the discussion (though some came after this). The
>> > > fallback should be one of the existing compatibles (the oldest one), so
>> > > there are no driver changes needed for the OS. Creating a new fallback
>> > > completely misses that point.
>> > 
>> > Using a SoC-specific compatible would mean we should go for something like:
>> >         compatible = "realtek,rtl9706c-wdt", "realtek,rtl8380-wdt";
>> > 
>> > Then that means we can never change our interpretation of how the rtl8380
>> > behaves (we don't have datasheets), because it would also impact the
>> > behavior of
>> > the rtl9706c.
>> 
>> No, at that point you would add the rtl9706c compatible to the driver
>> to distinguish.
>> 
>> You have the same constraint with your generic compatible.
>> 
>> > I also think "apple,wdt" is a bad example to compare with "realtek,otto-
>> > wdt".
>> > The former only specifies the vendor, while the latter refers to the line of
>> > SoCs this IP block is used for. Although I see the docs also discourage
>> > family
>> > compatibles.
>> 
>> Is M1, M2, M3 not a family? Maybe A series is included too, but if
>> there's anyone that maintains some consistency across SoCs, it is
>> Apple.
>> 
>> The docs are based on experience and regret...
>> 
>> > 
>> > If I may ask, what is the rationale for preferring the "older
>> > implementation"
>> > approach over a "family compatible" to match the common subset of supported
>> > features?
>> 
>> If you create bindings as the SoCs are created, then you don't really
>> know what's in a family, only does it work with the existing driver .
>> You only know what's in a family after the fact. Things are never that
>> clean either.
>> 
>> I just picked the oldest as that's probably the most well known, least
>> likely to need some future change, and would have the oldest OS
>> version support.
> 
> Thanks for the extra context.
> 
> Rustam, will you take it from here to add the two-part compatible for the
> RTL9706C? Since you won't need update the driver, I guess a single patch would
> do.

I can for sure, but would you mind clarifying what needs to be done?
From my understanding two-part compatible for RTL9607C would look like
compatible = "realtek,rtl9607-wdt", "realtek,rtl8380-wdt";
But it's only gonna be relevant to OpenWrt for now.

Do i need to patch the realtek,otto-wdt.yaml file in the same way as
your patch 1 here?

Thanks in advance.
