Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64D4FECC8
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912997; cv=none; b=VWYF0QtuxOIuB7pg+JeIa/fXn6XjjKdOCYf3HDtkIXFp13Rr/e3jr8NMmefjg8LVOtjjp6uilfnPOQ8AFDTbzgP61PEm69A2ruCbLVy5vqLbeUDJB7Nclftijl36LcALuRXP/X1Izv99xc2LZc8jv09GjNjZhy8vqCcwu2LhJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912997; c=relaxed/simple;
	bh=Y3m+IiRPjHXlRcCy5kt0s5eCMwrp2C3UhEBDizZT22I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5jY8jt1RjTslhE3P5RsMtwdoTi+nszrKgg7Y5+D5/wwRJF0LHttC/T93utVQnFHrrzfbmWUOjLfB2FMC39fhZ+QmyUdslv85oydPYUjsT3V5pZEpZVqo60t5AhPQoHC9f3rUu6lfwA6qEoaRs7yOIPrdLwf2imvmIThQ4Ld+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWSKRDYf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWSKRDYf"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a777d4f321so28064441fa.0
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912994; x=1792517794; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3m+IiRPjHXlRcCy5kt0s5eCMwrp2C3UhEBDizZT22I=;
        b=sWSKRDYfEI2zJ8ek2B8JekPO7bpouaU4ye6ZLMzaLhFtP1AhCCxqdVnUU1AvhKNrDd
         v2MC0OEebHbDFaMpOxCzNS6pSlTBUtHQmanosOVAV1K4Zu71B+jUWzJz/COc5WxhFuWq
         Ek78aoVLycp+SnFOteb/roZXxKhe3ULXz1tvDGSIGnbrBYDAzjAuiEdVdwxfPcQZgAXv
         wCT1j3P5xVlnwX+G31vpUkkaO4ImQpP/FcajorsT+5mbbirQUlS4Y3GW3rHli3jtu1lv
         s8V/49TqBiKHlLbI7Ltn08J0xb8u+qJiSyxKX4SGXaK4YjlXK3kxzIWa5tvhgxWXE14G
         XlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912994; x=1792517794;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3m+IiRPjHXlRcCy5kt0s5eCMwrp2C3UhEBDizZT22I=;
        b=eF6wcWh12XvpzAkw+Ki9KRZ6F0P0ss6P0rWmK51v67HAlkvp18IDxQRhTSfxZ4GECv
         A1IMlivxGmBZyhfoJrAto/2qiR+rxu/3AYFE6f8DfDiSg4dQWFycvBNKSGuQDpxUSQNL
         bk1OQNDyYQVIKaYbQBXpVGODDgEdKF1gNijQHbmxPQejSjiA+Wx3Gku7PdjLca2+uKen
         K7k642pxa/yv/L7LQusfnTN5Z6JcCcr+KtLXX7qkMJVmPeAh0bZbsEyrJNx7hqR6OoTN
         wrVVO6Ri0TZ7+7OEddRXL0cMWcxgmoWdDMU4vqU+Plfuwh06ZrlJDrhi1c+f7kxyiMt2
         YdqA==
X-Forwarded-Encrypted: i=1; AKwUvBzvtZvgVI9JzEE733ceYZKwPDRGjXZ5o0LgA5JCA+6pHInoRlW5pbR8/slxs5OJUHkY19Yp0TJs/ZprHNlciA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLPmuHipC4imwoNBb+IzYQpx4RZGyBrJtC007X8MzmXSvlIh1QV
	PpSIoL95dcR5wwL2nR83ycOjg67iH80eoQA9sYnwNHcaR91D9h9TgrLr
X-Gm-Gg: AYBFou3pnZCRDCQQkdYPPMAeJ4IxpaQD+3vFku3iTU3BPArBLFBwND25X+3xP9m80QS
	/g9McNB7NJcwuuNNfIOvGeWGdzo14+PRaBrl//E2+ObaEhQLph9MCh68zaYE7Fji2iy7CgCDUbL
	9CRSGvcTIMPR5nwDynOP83YFhGkZALo/ohJNgOXHa08fvQKNs1BjhxZJgZdGStDx808zImPEc/w
	kXKXT2XSG4AgxChFHRB3HiN6D5iGWL6olNpqrn58OZSnOdOGp8p8VZwjh4PksoGW63KvtdlCJqC
	VztlLgrr8j7vBCTKNm6Pd+0HeMj86TaR6XRwhy9xHQBjiekYGMVv1uHvdIXClSDu9igVzJTwsTo
	Tzs3CcQPOSDiBxW4JVbGvsdwZPc9qPIda4FfSdXcs3ocjRWzbSOCPFEPW5Ro7wgPDGGmCCHM2Sx
	nRu1yz9IOIm4skeief0cCIugf3Ntaogt+pWsmpBMyFgz+DkhtjJE+aiWJwnDj+4dkihTt0hXuFM
	iYTN0Hm03jKmlWUy7E7Lmky7lj0v2p67Awr7hqjKOT2mLg0PJDyOpOJN0j4rLxjm8EF
X-Received: by 2002:a2e:a585:0:b0:3a5:f982:9c62 with SMTP id 38308e7fff4ca-3a9c4eb6b77mr31027101fa.1.1791912993414;
        Tue, 13 Oct 2026 10:36:33 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c3cf7ffesm36421781fa.41.2026.10.13.10.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:36:31 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/11] Cortina Systems CS75xx: interrupt controller, GPIO,
 I2C and TWD watchdog
In-Reply-To: <20261013-plastic-dragging-8232efb058ef@spud>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-dreamlike-hazily-19bb60326f0a@spud>
 <179187542217.3247897.4323160442877168450@gmail.com>
 <20261013-plastic-dragging-8232efb058ef@spud>
Date: Tue, 13 Oct 2026 20:36:28 +0300
Message-ID: <179191298807.12554.2183121269667635269@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Tue, Oct 13, 2026 at 05:52:36PM +0100, Conor Dooley wrote:
> If things are just tightly packed, that's fine and you don't need to
> make it a syscon. Just because something looks suspect doesn't mean that
> it is actually wrong.
>
> In your shoes, I think what I would do is leave i2c/interrupt
> controller/gpios etc all as independent nodes.
>
> I would however model the pinctrl as a single node, with
> reg = <0xf000001c 0x14>
> I think, rather than 5 instances 0x4 wide.

Thanks, that makes it simple: the interrupt controller, I2C and GPIO
nodes stay as they are, and the pin controller, when it comes, gets one
node for the five mux registers.

I checked the boot loader's pin mux on the board: it leaves the reset
button line and the touchscreen interrupt line muxed to GPIO, so the
dts does not change with the mux register gone from the GPIO binding.

> My take would probably be not sending new versions until at least 48h
> has passed since the last reply on the current version, rather than 48h
> or w/e from time of posting.

Noted. Arnd also asked to wait for the 7.4 merge window to close, so the
next version comes on top of v7.4-rc1.

Thanks,
Fil

