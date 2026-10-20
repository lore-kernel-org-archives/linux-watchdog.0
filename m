Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505284;
	b=ib2C6vH/ykBEa7VK0JX3AmnZYhTv2Vsw+OzFA10+5GIYhHFr2xNeyHTF75Sb8dg/vKF4
	 /2M5iY+FjwMoWfdAwc4NGUrnQz3pYt2jzF3AtFVfVGIxDgGUI1P7gQC4jTVVx36hy2Z6d
	 w3oAvTCgeVG8bu/hvIemGPhGipJoJTXc2grmoUVufFfE5kVC3gjRqDWVyEs1jYqelOKC3
	 FUUWWeyZJ5akZPT5I27zt4a+TilVsC1a7kvcO0zjO9A8Et6eASNzjciBids8HSogGHqHI
	 AdibGH0M2tPW3zxI5maG3dKO0outlRZtbaYRoQcYuRXfBMnqfKJR0sgpPnf0bcfKXkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505284;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HyfAA1P25OiQxle+Wp/YWdNeqd49n99nmilr5GjgY6I=;
	b=CHSPcY/sOxcac12yCkYaWkjnaAX2sYgKrjutXU7svL5szhRlf+SQBvlgMGnvmQeH73pq
	 CFKfBkMOtPJ6wVKZQa0PYd8xyQALIQa/b2Vr6alRFuEJDbxSms1BKrzz554Im05ELWe7Z
	 I9HAd1JpeqDtW3LLXH31OXDCFrLDro1H15Ml2V8LaAXRqEtweFFxhYwRcZj7UUskZwfR1
	 Ivj4jvpvHAGkojjfwhMOIOd7cMOjba7hhbGdtdx1+hrreGDPuAQx4BOkpq1OhVLWmB1Pi
	 EKS4KeTVkElIk57/TMF5hjWUdjBEecTKx/SS2i9R6LXHQxzPXnysL3FdR0EsmpsG7Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv7g7XrF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6F60A2617;
	Tue, 20 Oct 2026 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv7g7XrF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D181F000C4;
	Tue, 20 Oct 2026 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505283;
	bh=HyfAA1P25OiQxle+Wp/YWdNeqd49n99nmilr5GjgY6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gv7g7XrFu6iTomWP2Raap8LiYG3LM4SG/iwjh6J3YDM1Ej5yARUkYWV31nlSAsyyb
	 pMyxrxsH+KoYlvWpwUIcYO2WV9Wc8z+Dx3bcRAGKkm8kx2HkuMLHbfoQialzCYFnbX
	 GXBT5sy1zDL/UoZOlZtC5JHaw4tHV9jx/leguQEGgfsK7LuBTh7i+zYuHexu8GTl0E
	 IOiAvLLuFpkq1clec0MdMnZud94PXLwCxFFCftnHewUZnRc1C32AS4rczE7Huq8VOs
	 yEU56D6eChXx9nCz+e45MwkqXnQpzWnMYGtwAMUgGJXfqlEFIUmC+AQs9Jn5++FHtc
	 ZPc0lBvdV+mMw==
Date: Tue, 20 Oct 2026 14:08:00 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 5/5] watchdog: w83627hf_wdt: Add minute mode counting
Message-ID: <atd1wP1cELjiwjXT@google.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>
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
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>

On Tue, Oct 20, 2026 at 10:11:58AM +0200, Paul Louvel wrote:
> All of the chips supported by the driver can be set to minute mode,
> allowing timeout value up to 255 minutes.
> Add it to the driver.

I didn't review the patch carefully as I was thinking about a fundamental
question: isn't 255 seconds already more than enough for a hardware
watchdog?  Why does it need to support minute mode for timeouts larger than
that?

> @@ -49,7 +50,8 @@ enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>  static int timeout;			/* in seconds */
>  module_param(timeout, int, 0);
>  MODULE_PARM_DESC(timeout,
> -		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
> +		"Watchdog timeout in seconds. 1 <= timeout <= "
> +				__MODULE_STRING(WATCHDOG_MAX_TIMEOUT) ", default="
>  				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");

The patch is obviously not based on the watchdog-next branch (see commit
b152ca999c5f ("watchdog: Replace __MODULE_STRING() with __stringify()")).
