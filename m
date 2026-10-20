Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460388;
	b=ax5SO/ZoANpxZrlLwAR0OY6yN3xrUlh3im5U+WSGdUuSvVrx8W2llut+3UHHf3BNSl4Y
	 TwWGAr/+P/1gbNvC0zRN8PdTxRK+8NiALznCN0awyla8jD2RHfusth3ZILKoL8gEdqTD4
	 Ug8+VGsQt4DutOfwLmbQzBWDWMt0w1b8vNusKAphAItjbEEa/QPaH2Pn8j8DmpyzgJ9C+
	 E8V0ctpVse6OhLX5mAlbaf3kOOyzJKalkRSvTPpZ6GpXCvG5Xy0w3r0LnIRQgj8MDy9r7
	 Q0pbFarAANAAgBm8YYns7RiDBw6WLJep7f8Jcbj6x344t8zxfSKGVIE+OQ5vyUL06gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RnAh5BgwbBUv22MFv8wV5yaYN/qwaGj857cNozmhPaE=;
	b=wwQAkUQDu5i8gtlw0ogJD7hAIWKuCZweqhyTtNC/VB1WqM3BPu0BA7X5K2fn10kDO9Fl
	 cHz47D+grZTNtF6lDlpkwFU+KO1pnV0Xzj2UgYPZHUJpGgNP6TFzMTHoA5RPY0pEPi8FW
	 jAmVNSQ+qZIYumgPP+IADGkcYweFZZwu+c4l0dwAMubkIXoh2nYKdgUTv2s/zRtcunC/Q
	 KTFN1k//dCM9Kt1E8761+FpSL+BxRhvQtun9gMhOohBaglOwqjTkCQ8Yi/hbHpGz69nvs
	 psuSPMZyOmmbshxxXkhLf8+tYDo0XLulX7KuX3hsHsaMr1lCQw6y/cXOFFspFbsi8Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RkcZ5cU4;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EC606A31D
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RkcZ5cU4
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so7151901eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460387; x=1793065187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RnAh5BgwbBUv22MFv8wV5yaYN/qwaGj857cNozmhPaE=;
        b=RkcZ5cU4XWT+80H9xiHfw/ZuxBl6gyGBS8H5OG1Ui5ovV0ctyZ8z4qUpRFqR9Cw3xk
         cE1gBX1g/vACLt1CLIrwHL8EmS5VeFqqrm0ueJiNdaRG5pmtJcXR9T0nI7/4wPFmx2Fc
         P6NuIHhpjNjq4DlS4dHIFp7F86kFVhySspEVGioyhs5SYNt0R0L1G+hf/6crdY5kskpr
         nh2IfgchMcIyBNiXQy8wSrHaA5HKlohWQIHEC0fRwpOhVMISs9wo+dk/5Oz2XD2EB5Cq
         WKb0vsQRYsDrrlm5Uw96Kk4QP2RpxUG/EAN5jYsQhxtaIKcG4NpiN9GSXndRffebXt6E
         7YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460387; x=1793065187;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnAh5BgwbBUv22MFv8wV5yaYN/qwaGj857cNozmhPaE=;
        b=dALIGUtvHjAJh/im25ijZRJVNrYEXsc9M7p5aEwViv7eSqLVYl2W+HU1EJbG7muZBG
         1kY1hzWyL1FPnybNka53i1Qn72TTOAZLDNG6wGZsi/+SJ2idyCA63OIvkA3kxiy+RaEi
         tXELQpt5CIv+ZHWMcj0lkghZqJspppvENUvG8DsZ5eCT6QMBASYZMIXdKsSrP1j/61fI
         Pna8mtluq3EP2gqSWwW2pr8hl2zziwr1iZAnaTFmm0eKJ8Npi7ROXENdrjlXMjJYoXMs
         D/EFDtoIhI/Hm6JKRHjSj5S5qcKJzbeAhLMFeK2zxF3tIHfzMr1fCbtygQAY2LYkq/YU
         rK2Q==
X-Forwarded-Encrypted: i=1; AKwUvByyyi4qp/Xt/tEmNMHYNqhdd56mS4Q/vP7mIDoAeD//SbFRhhtDQNvgCmWSI2HDfnSE6HVVdVDV15qucaXrAw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLf8ONvVLqeJvkaBsvetv8G+sGwBjFkETv7b83N+VsNcWYc0VoQ
	dc3KkDqM6iby5AtlK5Jsayrj2NgOf/EDAIsACZnp5kEVqwLDBwm3IBPX
X-Gm-Gg: AYBFou2Na+q57ot4BGGr/6VanBe5H1N75f2H4y3DEhiL3k+DtyxVqo+fkI0w6/pCZpz
	eyWdpXHr9wSB6iMh2u6c60qXKi96+sonwh06Yw5Qt8JppHDRvVv/6Bzzr+v+pNj6l1Usi2D248r
	yFestwnBGsDMy5UNLXMdMmncOi9s1wa1xdTHlsp78QKiohgX0fvlhR9z9VI28pzpALMAbYYfwm8
	vf9JQbJzsOZ0a3Tuk9MD8W6w5vt9GjY4qqJ7vit6h7kWxm547+tphbXYwQuR4DUMWkcwp6CJlBV
	LoguvwRQ79wIYDMAKX8S2W6Q0bW7OXaMyGLadiIDlqoq0uVR/YYSytlLeTkkK1x+cBN2KZGytSp
	+7GWpGn0zJbt358+x6XSZFHLfZHMU/pBOa4go14gxmDXIoP2SDwaDSLDuTbE4eCq0adJGe33XAz
	A6TXpQJxdtNrfn6OXJhkelefZB4j70OipE5Xf3gZn4Duuaw0UVDUP1ttBgxrX4yx0ZllrkTYE50
	OEk0fkh9KNh
X-Received: by 2002:a05:7300:7a99:b0:358:f678:46b6 with SMTP id 5a478bee46e88-361a2343165mr14073141eec.22.1792460386817;
        Mon, 19 Oct 2026 18:39:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm45216643eec.20.2026.10.19.18.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:39:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:39:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 3/5] watchdog: gpio: Support watchdogs with a minimum
 heartbeat interval
Message-ID: <cde332c2-3628-4bac-9a4e-55d85fe06628@roeck-us.net>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-4-f.fainelli@gmail.com>
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
In-Reply-To: <20261016221617.2223004-4-f.fainelli@gmail.com>

On Fri, Oct 16, 2026 at 03:16:15PM -0700, Florian Fainelli wrote:
> Read the optional hw-min-interval-ms property into min_hw_heartbeat_ms so
> the watchdog core defers keepalives that would toggle the GPIO too soon.
> Reject zero intervals and intervals at or above the hardware margin.
> Devices without the property retain their existing behavior.
> 
> Remove the arbitrary 65535 ms upper bound on hw_margin_ms as well. There
> is no register width to constrain this software interval, and the MTX-1
> watchdog needs a larger margin with a 1600 ms minimum ping interval.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

Thanks,
Guenter
