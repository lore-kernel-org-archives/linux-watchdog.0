Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA6327C08;
	Thu, 14 May 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774636; cv=none; b=rzf1HXRxRLUn1eJqFd5Z730Yg9/SQKKbbru23aAe6tdQViWkSDJxagsMXk4QY2EiJJXcZhdV1lcJkGmTtBkd/PCJE1rURJp6lVtrrOBKa/8g4BqkmE3so9BYDBun17aOC8bXqmGUh8glBtJvMhrjgZHTmPRuY7mHRWs8wD3PHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774636; c=relaxed/simple;
	bh=OEKUEAy0p53ShMd/bpraSPVLMD9PPRKadwTBJaCnYQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf5+IQiOVxBvVuuFII9XA5lKxBfD7oKgvvBe0XhpUhGzzqqWYCNjJXhZoT3jw3ECdjyJEj8RQxidn5jcG+WM4utZF1CEDRz1s46WMvaNUcY3AGGu3leAf06uiVffB2rJ8AOs1WBlfYxFwWHyg5a/DifPHNRJgG3/CXtvcR0eVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqnUNteO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqnUNteO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4024C2BCB7;
	Thu, 14 May 2026 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778774636;
	bh=OEKUEAy0p53ShMd/bpraSPVLMD9PPRKadwTBJaCnYQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqnUNteOoGz0KWQIXbZLG97Ht/vhGBcArJM+WFoi3+M3DK9pNhbI3b9yWzfbuxjyJ
	 xB8U1ltsTqdST+eJ17UDILgiqTlq76DFiDLS1/ooryI94aHQjCW3GUXCV4c9BmrOy4
	 tUfF44/Iw8SMdBZqDafEPI8j62ZLeARipOA1ZFT5bj9UhJYI47TGkpixp7X3BLiQV/
	 ssYddBeiDhJiAOeJZ+mqqPN7tTuZk2E5CHFaNOQgg+qkwwMh8zfWCxW1gbTwXuInFo
	 2aAkigyctbiLOPCFBk9r48CN0yS6Lm01+K18OxAI3KiT/k+PHmo5otsCK1kveXhFbH
	 aNqbmGDxMPMUg==
Date: Thu, 14 May 2026 11:03:52 -0500
From: Rob Herring <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sander Vanheule <sander@svanheule.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: realtek,otto-wdt: Add
 fallback compatible
Message-ID: <20260514160352.GA841147-robh@kernel.org>
References: <20260512204854.8931-1-sander@svanheule.net>
 <20260512204854.8931-2-sander@svanheule.net>
 <1be8c11b-a020-44d6-86ef-109418e1d968@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be8c11b-a020-44d6-86ef-109418e1d968@roeck-us.net>

On Wed, May 13, 2026 at 05:20:59PM -0700, Guenter Roeck wrote:
> On Tue, May 12, 2026 at 10:48:53PM +0200, Sander Vanheule wrote:
> > As all known hardware instantiations of this watchdog behave the same, a
> > fallback compatible can be added.
> > 
> > To remain compatible with existing single-compatible bindings, the
> > current compatibles are duplicated. New compatibles should only be added
> > to the list with fallback.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> > Changes since v1:
> > - Fix indendations
> > - Add deprecated property to old compatible
> > - Use two-part compatible in example
> > ---
> >  .../bindings/watchdog/realtek,otto-wdt.yaml   | 22 ++++++++++++++-----
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> > index 1f5390a67cdb..e470e0fcbb2a 100644
> > --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> > @@ -25,11 +25,21 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - realtek,rtl8380-wdt
> > -      - realtek,rtl8390-wdt
> > -      - realtek,rtl9300-wdt
> > -      - realtek,rtl9310-wdt
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - realtek,rtl8380-wdt
> > +              - realtek,rtl8390-wdt
> > +              - realtek,rtl9300-wdt
> > +              - realtek,rtl9310-wdt
> > +          - const: realtek,otto-wdt
> 
> For the Apple watchdog driver, the generic property "apple,wdt" is
> considered to be bad and is not supposed to be used for newer chips.
> For this watchdog driver, a generic property is introduced.
> 
> What is the overall logic ? Is there some rule when a generic property
> such as "realtek,otto-wdt" is appropriate and preferred, and when it isn't
> (as in "apple,wdt") ?

Never preferred. Retroactively adding them, that's a definite no.

Rob
