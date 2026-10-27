Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105005;
	b=1EWb1HQ/mRHCozwwRuKzuvp+iRLSLJWdUd+/QLIrHoPIzenKE6gIupE4NKNwwwrNwYQr
	 49ewZyo/L+h1vu/A1XtAt/VEcm9jVhkFuoG2wbaWPcIkEnHXzzlWk68wbnTtME4Hp/mTn
	 Rt13e3dc1xfjeREdUdls7AyuXWMYuiiH6jbfzals8bsPJgByB053Nl9FNqnUNrKGJj/A8
	 Ju4PtJd55ucRb2dzBWPW/PMl+mCF6XavOY5Z/HDlM/WF6SEOrEQ3/C3FLtb35d5mWhKlw
	 pWE1E6sinYe62rmA2DR+4oQcyu9umkF9mDaPsbmpag6gFuIv8IDpUPwYaXbUSsFX6bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105005;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ggQkqgk2U5BTlGQlSEIq07Z71Cj07Wa6DZDZXmMq/eA=;
	b=JAiYMz/A68SOQJK7aDCYrk5iIO1APyiMAtbkJ+lEM/LnOhxW04NGQ3OXBJ36MRFFKj9a
	 aq1AGe7jRU2hbl4Wl7KXbdO2fXaf12MLukmRr8b7rLhMAzf5Z979FFoMHjXDoG+X+MPm9
	 HvG8fShaD44disHmRZTk4B7yLKYNRd5DR9HZD2IouZisoGq6m4Bo6nBBlZLBhP9BNA8sV
	 vl1USQc/Cg1TQYfvJwo/2Ug5JBoIPsqoTnz/gqV4vq+oJmc6FasVDkeepYHbExkDyb8B5
	 QE38qCyJYm9I89tf3sUysjhwcIQYYECfoOPq4FrD1ukpZX+ImYVGixcJXqWVB7IJcxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UqPomS/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56584606A31B;
	Tue, 27 Oct 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqPomS/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A301F01828;
	Tue, 27 Oct 2026 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793105004;
	bh=ggQkqgk2U5BTlGQlSEIq07Z71Cj07Wa6DZDZXmMq/eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UqPomS/wo0mAz/Nr3NJ7qEBEtHxqQdw+H2pwiqEzoROGhNjGRcFoQN3A21mXGjHNZ
	 UDMuaWNpqfKWKqU//5bMmWYe1f/ICiJhoPMmTGW0U69jmlo4n6pRrDX/Eejtsvu6jJ
	 CCAZTGr/1dW0br5v54H658hIha0C3dQMABDphOgns/jwZ6Sa0PgLLEllO47ylvB/h5
	 9h8MhinglHIvvLe+gqNjRp0+ME6urMWJXr/ATZZu1O7J9bkTV28ObfS4KrH72kHpHA
	 kAamFHcozMkdeaSueuhsLaZKwDzOjt6mgAp3QeMS/DOKQns2+CsUfOQmCZP+SHIki0
	 NZB2CgCbO7Wag==
Date: Tue, 27 Oct 2026 07:43:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: add reset-from-wdt-gpios
 binding
Message-ID: <179310499987.1543508.773226301896482465.robh@kernel.org>
References: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
 <20261013-v7-3-topic-gpio-wdt-v1-1-bc98f05a4578@pengutronix.de>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-v7-3-topic-gpio-wdt-v1-1-bc98f05a4578@pengutronix.de>


On Tue, 13 Oct 2026 07:54:27 +0200, Steffen Trumtrar wrote:
> A wdt-gpio can buffer the reset signal over the reboot, to signal that the
> reset was issued by the watchdog.
> 
> Add support for a new gpio 'reset-from-wdt-gpios' that allows reading this
> buffered value.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

