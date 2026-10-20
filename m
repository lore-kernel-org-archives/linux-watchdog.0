Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459871;
	b=gx5uSuWkP8hfIeoH3a2/RA2qEWYsCfSjjl4/G8reSh3gC2qUZwgxSLw/SThaYjVPjPIh
	 YNicAEZHZnIrfobwduE58OI8QmWyC1wwZ0gdOoD4kbUFY2buhmIWOwDc5cYon0UVBciKw
	 f5Jlo8rRhNEgxF9/p99nYhKJ5vwBD8NEZGdKlrXR4ilC4SnOTArTS0B+15M7plDTuyZJ0
	 erHLP1fiEvLHBxZUyiWFKyvSNPQlqbvM6/l0ALjIfkm4zRFE8JUxAb+L9C0/4RAWXiHsQ
	 yb3JVx0Rz243omgZ8qDMmFRegUZEAUxqLNNm9PzsetJbOyxB4mH+esDTHqAIFTFpIAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FzrF64kiEKqqwWT5o3bxL2C80x1Hbvhrh6y19AZ3iRw=;
	b=m99iwkI65mDudscRg9jdvTVv+BETZUKOoM0snlCrhVfaR+PZ+ATUzcr6ng9NhtBIhAZi
	 ytXhoN7Bu20TrkFe4gTyVNWQZ+VgAIwOxd+H+AkDEW6GuNWOpbPLANoLvvD+yRf1prbtW
	 F8SzRw5KdM5mDNB2SFzoWJW1YAHs4uRS6iemfjJcNmwnIOXH4knS4uwKG4sMJNikuA4SD
	 jBRJaMoqgoEDT+UzlptcUaFJV2dowH4Q7zqhaixU29YhTXLXsNoaQ8sYtpMO0RgHDTebl
	 UYTHATZWpuQOLdofK/YycVlj1dEDSWUR+22WOhW/hLIgmvj+5KZVz5IztF3EzLon2nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aPdLPZff;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE2606A31B
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BE2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aPdLPZff
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1329361c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459871; x=1793064671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FzrF64kiEKqqwWT5o3bxL2C80x1Hbvhrh6y19AZ3iRw=;
        b=aPdLPZffNmo217G9eWGlRm1FdljKwmlMRRhAYx4MmC6SLEKjyRsg8qO+e+UU4wGfvK
         IXxJKWu/71cohwDuIAM72o/901AzzXVFeZ77ai8hv9VfcGWR0iGFF03S3/8r0AkeI+rk
         MmEHUgxBULR6/gEWt7F4jqrP4gB06tCzw0R36h3mYFNJwFKdzxAGXo8xSDD1cUZaKixW
         JLRFEeZ5KnqR2IQdmpyRdrLMGxT2y+7geNUYN1cc7/3tZDN6dfb1ONb+fawinXq3kKiO
         DQl1LKXtuLia+4Ta/39Xng8xFeZ6ebvCiIWk9VWm0rM+i2YkypHQHTFQDBxHRYI3Xgfc
         72WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459871; x=1793064671;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FzrF64kiEKqqwWT5o3bxL2C80x1Hbvhrh6y19AZ3iRw=;
        b=pOKkk7cCrNX/ySo01JfgfeQCORPa55eYlVKiLPC2NVlRmx2dA926lJEnFXg/AVX9OK
         Ffh+12/x7lXAa616r4oREnuApky4YI5a9Ff9hI/t5Ug40kLPFYG9u98vXKYfJ8RvZH26
         OyWAEqWX3nmBuTuYuPLlFF3XKY41jgd37ztbZT9EdJojAVXJcTw/Zx7N/uX2ybeESNPw
         qa8rdYgTmKnnW+q2X4/q40xhzXDK/OZK0alvS8LU36xA/BEL5ZIdjKD1F2ITxmLLYVMy
         eeEL5nGNPiymbNcOW2oOxF+xbPN1XS5vHzBjvUvFot0rVgOeP/JSnYLt1s1X1wNi9OZq
         V1Pw==
X-Forwarded-Encrypted: i=1; AKwUvByzHpuryUzt6ew4EWCwIJ+v/MGNGaZpJ+EFBB/Wr4GVeibvRClbw40r7cizH+ajN5ERImk7qdas4iVcbnwMUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbf87wTj6e/HCVmbTP5Xwg3npeBpTUZ9PJraSaRsG/Nh2tl6zT
	yBn4341odJ2l99IlUmJh2+SipZkCAhh+kaPXWu7LW8i1oKT0mRHbGwCw
X-Gm-Gg: AYBFou2C/L2Cajkakt/Yks7WygfEmoYKRrME1JYzM5uDBjYRTj4f3ocyhTxM9ofp2ZH
	/qqFLCcfHnuR8xr9Nd3Tj7SontblbwellOSp64oXrwIWiEGKM0Ml83qlivSO5VZH2km47TXNm4H
	+ibA6egdI5ELFdVMuIB/buZ8SqdzW/y4JryU5gcMWGvQAa89vCrKqSEYxn06oLvUagY5wxuWvy9
	spAUSYpDy1Z4Czk/a+w/8xI3830Khvs+hMcJSwZIDqcBL3lw+ZlJ2ClqbgmmODpqQqMmApr6a5G
	W3GspGBYrmgfsKDcDI0+hsEczaAopNavEday0XBLeghytpzO1hS1sBJVFwhmGD6qlTY/K+A0rBA
	KWh07CshVj9c1oJCJbtDRSdyXMRvyrTRICUL+wz7oenUOw1CYf65Lqm/7xz4ERMZvmaLY5fKTcD
	vJMo7uFdkIv3B7NYjOV4v91s58eVhAZ/NQe6yUiUorYPAWhq5ej8qcYGpQirgiwn3thRqMJV2Hj
	e0fkMF+vg5p
X-Received: by 2002:a05:7022:f51b:b0:159:aa67:28c1 with SMTP id a92af1059eb24-18512b3e25dmr13513794c88.20.1792459870405;
        Mon, 19 Oct 2026 18:31:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-185aaea8b24sm25427211c88.19.2026.10.19.18.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:31:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:31:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: qcom-wdt: Document SM8650
 watchdog
Message-ID: <4b808464-c860-451b-b179-fdaa39e14fbc@roeck-us.net>
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
 <20261002-topic-sm8650-deckard-watchdog-v1-1-7d7f7d71d88a@linaro.org>
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
In-Reply-To: <20261002-topic-sm8650-deckard-watchdog-v1-1-7d7f7d71d88a@linaro.org>

On Fri, Oct 02, 2026 at 11:45:28AM +0200, Neil Armstrong wrote:
> Add the SM8650 compatible string to Qualcomm watchdog binding.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
