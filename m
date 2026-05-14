Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B8336895
	for <linux-watchdog@vger.kernel.org>; Thu, 14 May 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775934; cv=none; b=Ax8l/pf13W/d2ae2P9KRCUqbmMwaSrQSb2Jh8ZPI6/LyFZ8i0kLbYWmRQSzkUYTqfcKt4HkrRCkhofsXJhlQSMDWa79XneudWnniWYRYSYoOCpHDJVrGzZ0IiFUIqYSWA2TrVW9353n8QtLkYlWmeqcs+Lb0O5J6SNOxwvWN0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775934; c=relaxed/simple;
	bh=oz0QegTBwH7k/4bEaCDsAsTH/abQuaxznu/zTh3nJyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQqGwKEaSIAEbiPbLey3hSFIOsWlxv88zmhErC+8ocZtJxCXP75jw9u8X2lNcUaLPAZykaGo8g8NtKM0IsnGOI2oU6S3iIVrvgjr56ePvF1cX7jW9oU7kv+yETuScaGxW26Gmt/SOCnfkwVLFcbLLA2imw2bR9Hih20MZx/7QPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=NI6rPYYS; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="NI6rPYYS"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id AF1FD77FA13;
	Thu, 14 May 2026 18:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778775925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX23KwxWpTu37ab+QJbRh348TqfNCeLawnsdN64h1Ac=;
	b=NI6rPYYS3tN5ctyRWY2JIZz5dDS1gjFP3iyR08IBAfec1peMUC4tZUHMvqiyWXr90hFRhS
	GX2dYjewiYk4F+zwMEOuD8PyWCQo50ozlgFtq2MGUU937k6pkW69cpoj444y3KDxXgUI/v
	briL6d4uQ+q7W353owpaYcO6qM8A+f9gYFQu8cRe/BCCRKNG9GNUXAWu+9oPrA+huQsTva
	xUffu4vySykPzzdjS2nRI5XyI1bAUl1zAfsioSsXNWMJMLbwx8ux6kfZGg6JC9+DF1bsbs
	K+csw5i7/14FyXN1XB9EJx37oPxbuxx08m1QPq/om3vSAkNi8Kq2i4ZTJiyvRA==
Message-ID: <9f81a947b65cafd44b293e05080b1fd2820cea06.camel@svanheule.net>
Subject: Re: [PATCH v2 0/2]  watchdog: realtek-otto: add fallback compatible
From: Sander Vanheule <sander@svanheule.net>
To: Rob Herring <robh@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck	
 <linux@roeck-us.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Rustam Adilov <adilov@disroot.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 14 May 2026 18:25:23 +0200
In-Reply-To: <20260514161008.GB841147-robh@kernel.org>
References: <20260512204854.8931-1-sander@svanheule.net>
	 <20260514161008.GB841147-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-14 at 11:10 -0500, Rob Herring wrote:
> On Tue, May 12, 2026 at 10:48:52PM +0200, Sander Vanheule wrote:
> > Like for the GPIO hardware of the Realtek Otto platform, add a fallback
> > compatible for the watchdog hardware.
> >=20
> > For backward compatibility, the binding will still allow current
> > single-compatible devicetrees to work, but new devicetrees, including
> > new compatibles, should use a two-component compatible.
> >=20
> > This series serves to address comments regarding the device compatibles
> > for the patches adding RTL9607C watchdog support [1].
> >=20
> > [1] https://lore.kernel.org/lkml/20260509163101.722793-1-adilov@disroot=
.org/
>=20
> You misunderstood the discussion (though some came after this). The=20
> fallback should be one of the existing compatibles (the oldest one), so=
=20
> there are no driver changes needed for the OS. Creating a new fallback=
=20
> completely misses that point.

Using a SoC-specific compatible would mean we should go for something like:
	compatible =3D "realtek,rtl9706c-wdt", "realtek,rtl8380-wdt";

Then that means we can never change our interpretation of how the rtl8380
behaves (we don't have datasheets), because it would also impact the behavi=
or of
the rtl9706c.

I also think "apple,wdt" is a bad example to compare with "realtek,otto-wdt=
".
The former only specifies the vendor, while the latter refers to the line o=
f
SoCs this IP block is used for. Although I see the docs also discourage fam=
ily
compatibles.

If I may ask, what is the rationale for preferring the "older implementatio=
n"
approach over a "family compatible" to match the common subset of supported
features?

Best,
Sander
