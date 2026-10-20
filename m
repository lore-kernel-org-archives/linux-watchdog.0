Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460451;
	b=bEIUrL93rQ9KJPcMyAasOZy+al3huYwiQi6W2jfG5lTe4hYjcWfo4264kG+3I8iwFadJ
	 2YSU0QGRxTSp7wq4g1qx8zNQWh2/mByXJjaKrqJryLiX7BcRoQuatuGWiVcGxAO/DPaKl
	 htcfJI19hqyRE/ViCwROqhSRETcVvduCTMcN3oqz4w+wFw8hrLorAOBsIVFbNCOY6mcbS
	 iM4m1osQCqr2yZ3/eNFdEyEgXJqgljXh03VceX9dFsvU114slZsPOiPmks6BXtYbhh/Gb
	 MtCAAXrbl8Q9xKSs1vU8xRIvgHISozQR7U56sCbENifd3Vfxfo/Iy2lGT3Z6nPXGRmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PkYwyHMfJbGSQ+mbZIjKmmDSlODNjZUoD2Y1WRfOazI=;
	b=G4csqlWT6uvf4ukFMMtCcchcQBtX0B8Q/LOKJIRMxuaUIn4zsN6d7mlR0YSHVCqZu7ze
	 dY9a0VfCYJH3i4lwJQ1uXyz+dsvAKLe36huflzrD2CJctJoJjF7XBucSYXPK7ciQ3a9mU
	 jyN7o3hTTC64U6+pApkkwhhPoXCdpMu2+VXlB/+SoCdXFzbydSheKdO5V6B4hASvi28iA
	 4ZsAErURrsGjgwXmq9cgLnDsBtrZdoPNpwhDpUJaxvCD/7iPcGNy9oy54bKC1eTfgItWm
	 y8RpGpP1NjmkOJJIssYIPGK95FSixAPn9cXXyAFyhTK2r+0ThilAbwAGLF7wmZv6YDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yw62Pw4s;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C7606A31E
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yw62Pw4s
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so5821133eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460449; x=1793065249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PkYwyHMfJbGSQ+mbZIjKmmDSlODNjZUoD2Y1WRfOazI=;
        b=Yw62Pw4sArCsnM4IdWA5utZbwB57JnrIB/2ksf13OnirkbBAHxX5H6BkW38Rzv38V9
         Jin482MenoCD03jbOZlXql3n0wYe8AzMAabGsmL3kspaZexEQrB1Z/FIIjVVaOLNSFMV
         REXeQKHygLmkr1iDNCPmH/vWXmy40RIxqgHqjWwBfnqAJ+tVBjH2Cza0VX9bb6OubqNu
         J+VoR4I5sGLm1KHMh8iKnS+aFN3TOnDt7AkFQRiqD9Uc5+gRF0fKtaaTiVl2T8hQycA/
         EkdF6tf9SBJreYCotdl8RwOB+iUxY01relrAtgBZBt8B21DI3/sXa9ZG4QOUg6yiKNDS
         E0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460449; x=1793065249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkYwyHMfJbGSQ+mbZIjKmmDSlODNjZUoD2Y1WRfOazI=;
        b=27redT8rIx8jGtp7jhRBMDewexWcjtwGIxSA0Kr3RirO58nraHwEHPBBplsbpSL5vf
         hHyW62ywSWvD74N1Unn24Nhm9I1JMxZU1MpL6tD4dGhivUs0kCyXcygVg9oXwo9LFA+5
         rWvDEgjWVIU746ok1aHGXmLL4ohuv6luqkXlvNY3dEa52qacE/ofc5meTeWIvA/+6ZRc
         mhl99eyo1JEfO14AHnKkZwd77JgG9FPLS3kK+tqWGX9ifq+hpMAS2aXgK29zh9t0tlnm
         /N3Z9R8/PpBz//zCsr/8pbmW5Fjk1gl56w6NcLAx/V8PKKANokTpK5iY2QBe4P6LGLV+
         jpvQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8yHTGXBtf35gQzu5K3g65WB8uvpZeuLBWwOSzsy4+Yi94vwrYseIUYk6dwPs52VNlfS6hfmy6VVx4p3rjWA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJM1jmGrtFDJDik5ttsHUT3MN+uXzsnVmsMIGY6UKufZfUqr9X1
	72sn0oep7zepJUJ7EGMHIhR/po2BoE6WWky+OcXgbScTOHZxOA+dHi6G
X-Gm-Gg: AYBFou0hd1yI1vX0bWkJq2ZQ2t5NgoyYHJGn1o0XUfioI5qRiTNEbS+IB7kza2+WgMa
	40Mnnkqe60Vs4Q3HwP7eCwJfe89pKj3Bj4YC/FBLX0ZK2kt++6jVxpYXcXVneFO2qHrysvBrnxf
	sDG9EGJG7k7RK8U6AdWs/iHmo3Dp/vcy07Pvb9uEkod/49Kinr8q3o9HwrJAdkQKJdGdZf6v3NK
	8dzPp9btOLCMWTkIyijbc+lqFxhkFO/+q9E2AjuDdXIbfAwwlnxhf8KBr0rzTJuYeoBNW08nGUp
	j/xUSOiFQde+K3uuIK1YFuX7Nm7azpOv6SgDBglbfI9weQcNEQaKeuOp8cUVWaO5e7JsNJhlWA8
	QzqOrZsQBO1zEAoXrKbkire6YqiRWnsEvp/3t7wCmaSp7WQ0MJ0iEVSnH0r20Biqvm3HgDDDgrG
	GV7VcH3xO+PQwssD2Pu0hIvPI/7gJ8EaJTQyqRSwXABDLykZ684l7+29PiqSWnFzWpnyXjKdHRB
	CvaZ2jD8ULt
X-Received: by 2002:a05:693c:810f:b0:353:7d17:9a86 with SMTP id 5a478bee46e88-361a2549c60mr14463175eec.26.1792460449367;
        Mon, 19 Oct 2026 18:40:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm36078733eec.19.2026.10.19.18.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:40:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:40:48 -0700
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
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT8163
Message-ID: <efbbf24a-59ec-44c7-8738-13242c7cd90c@roeck-us.net>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>
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
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:40:01AM +0100, Ben Grisdale wrote:
> From: Ben Grisdale <bengris32@protonmail.ch>
> 
> Add a compatible string for the Top Reset Generation Unit (TOPRGU) and
> watchdog timer on the MediaTek MT8163 SoC, along with a header defining
> the reset IDs it provides.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
