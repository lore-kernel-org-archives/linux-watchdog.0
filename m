Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460483;
	b=jHRau8IziLFs1wm0uVmQz3YXu+TwI07JQKcBQ+sC2HyhfnInZxJ1IbqvNzxw+e6/f4zj
	 M1Rtk9R+kXagcZqV2LRCgoUVQk3/zaFMfUIf3zrAy1J9N2QL49PO+N20RKAVSq2Cq1GQ5
	 Nv+XgOCJ12tNjOhMTg6spXf4DflXVWp9+3x9woKzeKDAVYJrQvqCzp4JDC0/e9tIuDeix
	 9X3/dXDO4kyU/WMI9uLX88z6uC5GguslkWC0ztyRDaIzjz4hyi21yc7+RX2k1E1HdvYFL
	 hAUnCYONKHPHnSWi3hner+aGPzgQ6Ytka1M8xanW3X1f99Z0qZg0VHfKUSx42rMog4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fr0TV53Zh4gczCXYrk8qJ7Y+cVmeHFe014wAKV8qTsI=;
	b=i+Dc9AoEbuAN+UGF+KD4X85bsw8sP9Q5HjGqtrFv8s1gc1jY7vlR7Z7O3FOyk7kkT0G6
	 3IVIsShDR7mL6hdLYiNoxy+sb7A7ygTM7JBkS60NLqxQ8MfQApIXu134qPO2hpFM4bjTA
	 lNpWvhE3/1wCr41LH4MYeB3OzPZ/KD3RK+RdfI1xSYerZmwQ1Xxvuw1JBWlJDMYPz130h
	 9XH0BFoOqjSXhb5FKDdSnTYWYVpp8Qt4iqc/ffMxfLW2w6tsY2uoGmfXjUz33Zc1dYnva
	 ES44JuCGhNaLTDzm5TtVMQE4bK04lBbLEE1p961D4xnNy6cZ3rkcMieDH5EHcEvjGwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QczcF95R;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13915606A31D
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13915606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QczcF95R
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-17bc533fda3so3192447c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460482; x=1793065282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fr0TV53Zh4gczCXYrk8qJ7Y+cVmeHFe014wAKV8qTsI=;
        b=QczcF95RLqhKlbaXAMGeaN1AxXkPoihUjRzwJVbthf4GI55+lJ/tDi12lth6tKOKgS
         cTy0iOv691TwhqWhbFHkeMyngO05h40ol7fVkPUdDShmb/rxRNfuCGVl2BfSZK0Mttn5
         5MixBOFNKTY/fMstidcQZ3LVYufFQ3YWrTq9F4AVmrDg46vLcoHy8iKXwR0XM6Y7sGKp
         1IDs+Qj8URbMRiTauduB8UaIxqMiKMsUanldJd5gaRaB/+PvGIjPk6j+FFOenOkaeN+D
         eU9fsubgP6AxXusE7HElU6ZprcnCC676R3EJf2L6aT2bUSjW/DlIBnLUfV3aBygH8Bfa
         DeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460482; x=1793065282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr0TV53Zh4gczCXYrk8qJ7Y+cVmeHFe014wAKV8qTsI=;
        b=LBA0NY25y+JokYtK/Ji1d4PEOdFp9aA+4bKT0bzkb8UVJKSl/bjsZ239nejd1ICLuv
         wZzHWPWexIXqc1PhlpRFWLEYQA/K7fmzuAY03iNIRkZ+rx2v2BboDfNpqw4QWzSf3fpq
         HR/Ai7tQvWUFgWEMKCBW0vTq7k6yrJxMSsBcyP0rQ+8WTWg89Gsz+nbn+wvruWWzFpes
         HGuCkdwqi/IbYb2P29n0WEqzO7ELYIuvZzXfAnyqcqPP0JXmSKmHKLO8i/IQM5weyDeo
         inQ/7t8X9K8IJyhiKlVeuAbfshY3muRvkJlbsoAsK3vof8U+UlTFWEUIeSjEfj/lbFjK
         /EZg==
X-Forwarded-Encrypted: i=1; AKwUvBzMrbD5UZ/g4Fw0DID+UOCNDZrGNV62B+K2kfdmSC4SU9fZsqa0RMmOXHy7C8afWdOU2kOkcb0ON1pxfMO1GQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL1QlSIhbUigwsuDXoAPL01wbyeopJHFxb3ZY3vkOPVYYfu6qsZ
	fnWmIBF93D4YFkVOPcbLf8DqOPlRkoqqjFcNpxMThjyST0qf7YfmcLTi
X-Gm-Gg: AYBFou3daLl3AhqDmfovIfQUAO/ZJ7aF8XPwhCvNiDwCKVrmI/3hBExs9Fmi/H7RpCG
	wzvbcHpO5inVMd+Ro8222Pi5atrjrUnEJ2HS7pYFp7vY5Y847wGSWBHTGVgrrO7WvXjkPQvIKDo
	pglrp7oPbc1tpXzNXvFONADHjIpo5Kb4Ns6oRPsHObrgo0/+Au2bpAsax18Q7a0qDX7aUtR4CpK
	ID/Q/uJ4CS8NoNdGz+Z5miqtuYjMvBCSTQj3aNnkln/1/IqUhNt5ZUx3JTTGRmxjark2pNbbFDK
	j81cTYpRcY+1VthNCwYHm+Jqggh9Lvq2kltf3oU4xIR3A6W3fh7joF0GiUTSPlRz7brPv5JXUHN
	aFRGy5vYWYEg/Xv2pB891lhymSNtQGz/i0Tupl9bhHdJTwmAWGApunHynbO2COJMWjO0A5xCMqw
	9FcOYCL/xs6x4qxMHRhcD8RIojfH0AO5/BTduL1TLDT6ZVJdkJCBxEVLv/8XSrCvBSRFNcKAxMO
	rOOFH73qEdbhsJHv1YwFEV7F4oL1Ix87tVfK74oQumqVgsZF2TLPj5z+dM2XOnmbIY9lw==
X-Received: by 2002:a05:7022:ea50:b0:143:2968:564c with SMTP id a92af1059eb24-18512f1e993mr12640931c88.26.1792460482105;
        Mon, 19 Oct 2026 18:41:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm28816461c88.20.2026.10.19.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:41:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:41:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Grisdale <bengris32@protonmail.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 6/8] watchdog: mediatek: Add support for MT8163 TOPRGU/WDT
Message-ID: <589d0ab4-46cf-4b8d-b4b3-5519dbf030ea@roeck-us.net>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>
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
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-6-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:40:02AM +0100, Ben Grisdale wrote:
> From: Ben Grisdale <bengris32@protonmail.ch>
> 
> Add support for the Top Reset Generation Unit (TOPRGU) and watchdog
> timer on the MediaTek MT8163 SoC, which provides 15 software resets.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Applied.

Thanks,
Guenter
