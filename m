Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C194368276
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097831; cv=none; b=alXoXkpHcCw7CbgcX+CpK5ulRM9S48eLhyI+HGcytPaYdYK7SAOLqMPnWCrTc5xgF6buktWk+1xuk2rgGFWA6wcs/ewLDKpGDjlBQOW1ZpAtV3iS5OTVHdBrU6wOlyaOR+7qHTkc2gfL0fpSAaoQ0AccC4VlvJCS2Pjauoo47gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097831; c=relaxed/simple;
	bh=jnxbrAUNCi8h68fjyd8ZlDlk84mac5zqMfeH9/mmBI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boPOer+urApKbRF+82AlgTmk2if3Q1Y+RtIi1aDv+PDNmMj5izJrgOKw5B05MNt2pydmN03KdrfcJrgJ1PYCYSXQnWM5wYVs4FHJpj1rRYT9RoiRX0uCLcxAkW6YKU2yPvhtBE+1+Lt6/Jt1BGwpXzfp/bpoqOul56JXqjSUtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkYW/9qB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkYW/9qB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so416578a91.2
        for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2026 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789097830; x=1789702630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vTrVSBkVGPXm2gcTE8fmlqXbs+T/1ViJad0b75wnA3w=;
        b=MkYW/9qB+6iLfHw0caDUOAaqQ0xW6BmFU5TPmQLgofu5E8WvDUpp5SCiYDV0OdmClx
         QM1OvYRzSzrnFztyGMHisZgzsUxP63IUL5u4qWYFpaaJOQq2krPJ4mHy+4sCsUmLWH/p
         AQHaq4hneBsoqeSS1ZNjvw/cM1lv5Z8aj+8reIWneQC5tzHMaznaXS9RMz1KcAkI0IaT
         pDIDX+c0TfdTZ1Lt3UTaNX3gxzBBXYxAf7SHdIyK/dSIwILSCEaRsJVUUuFqqqHQyafA
         xFax+V3/bVFZzVf0PIAKz7yWBxfcSzlVJOoXeuH+0nrxFaXT4BXFrqzwiL5ItwDbjCnJ
         ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789097830; x=1789702630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTrVSBkVGPXm2gcTE8fmlqXbs+T/1ViJad0b75wnA3w=;
        b=GBAVg5DBPcRD9bBHV5vE7SPaA8B5dAgtaiT0gqhPzsopv//AN5U1U+yVL6Akp+akee
         YVen45tFiEtv8psysWVArwt78POmlIzGQcAHHoGvDGjH21MYdH+nMVpK3wcp/6lEnssA
         8JrrbDB/2UkRvZY6vwVxesjvv8PiyrfRFWh+KoaFQuFq0tE4h1R+9MvdB/i/ut6PU8jq
         zH5H4DhENzePj4MJdqGSEjTp9wN+nFqcRwPL554ld2ZMGFJg51qydLnZN5JvmihPASbe
         kxgZnVkXTiBDtbJQGN2DNP5iWZ/y8Sw79CxsQKx5t/HTSuV1SRjH0PEdFs6Wxn5N/Ug4
         LvKg==
X-Forwarded-Encrypted: i=1; AKwUvBxQayKnsXnvYrPhkAvKaCLswhGx25jJ0aZrjrNmKjOSTo7fGAf/mHLZiMEcrdyShwsJ2Kcop4Adv54bCgRh5w==@vger.kernel.org
X-Gm-Message-State: AFuF++l/p3k1sBICLXdWB5uSjqUZ9sPgucfQurWcvwmauge4pLE2i6HM
	wyqM66MOAYuNrRDdPvI7qxELUzAsg3FSDkEfR00HJMKlKvn36jFEENSH
X-Gm-Gg: AYBFou2s4MvTtlGGqahJKj3xOOzWQKkw6XIWWYR7BlJE+bCb8smXLC8Xe3S5Zw8rtcE
	sa2YrQpHzt8VjjuXxjMZEaOEcxYurGg6TDbmgHags2AmkY72H+wKt97cRjLcun6TD35zJpT2MWG
	FbnyKKwZJrHqqqRvD7CJyqSaQoarDGVEcgpsMTTox1oddQh9pjv6x+7qkRqQvkdwXY+sVuYIi4z
	/3UJacus2Sp6dujvU9IM/3qjH8vJeNc1p2itpMHVrkivJt1Vb0Y1Wl8GQjR3+Q+Y83enoEr2HgH
	kiGD/XMiAH6Ey5WzqssSY9VhLSYhx3xwrNjBuS37dS8l0isAUyMZrg0pxy8CJ7pQrykL7ZKVXq4
	98lQF+sBP7KsphZzwYp1/UaXJzyv0XzUX9Flc0CVnq6CJM1WO88sBec0QtKsbKlUsDFk56o2Kzw
	22LqCw3bUpRi1i8Ew1ZGtZHtuGkRl/M2bg4EXItMZ37qwqfzaUNpndy69YRyg4cAH26LBhdcwZM
	Uvd2ZNLMGHhRO8ydFWwIvQ=
X-Received: by 2002:a17:90b:384f:b0:39d:8794:5564 with SMTP id 98e67ed59e1d1-39d9c1c016bmr3307088a91.12.1789097829777;
        Thu, 10 Sep 2026 20:37:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95713602sm2537488a91.11.2026.09.10.20.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:37:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 10 Sep 2026 20:37:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zakariya Hadrami <zkh@mailbox.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, zkh1@proton.me,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: watchdog: mediatek: Add MT8127
Message-ID: <8bd4787a-1666-4f92-960f-287bc3b918a6@roeck-us.net>
References: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
 <20260910-mt8127-amazon-ford-basic-v5-1-3cb9eeaffd5c@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-mt8127-amazon-ford-basic-v5-1-3cb9eeaffd5c@mailbox.org>

On Thu, Sep 10, 2026 at 03:29:12PM +0200, Zakariya Hadrami wrote:
> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
> one.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>

Applied.

Thanks,
Guenter
