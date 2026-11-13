Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531547;
	b=DWersTdeXhyv/p9xaB0FJvSgUzEjYq7sY+05JDEwLNKIdhF8czaWd5Vytfn7fpupxerz
	 F1w7WGCyry7HOPdPC8Y6WffRYUXo3CMynM30sYVrQIl7nMQHbs/MiD0t8IXxkxWZiVuEZ
	 /xbP0NR6WADaT2HTXLqTitcoDQhC9FjpDLYx9DlL/IjZWmzqbcDVgwIt2rnOjNCEgVNrE
	 WwNv4McXbrQ2CqzT/QCORW06BFbxaIb/hiIXbhwB3+hD3PotAU5LFSJ2/ewB9eU9gC6KR
	 0OhDyISHOAqNP/6RCEn/EDApSgsVv/5IKM1gYWKDhtsScihRkuDqcA/d1qe9YXgtvhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
	b=V0jIMiIzIPuycEFj69GSineXn1RDpKDPj2umC09hUSkAB0XLR7C5P6+kjl37c0yK7PFy
	 KOQlcCbpsKJ+HkmIX8psNlUC5As7OhWqg8/oZjbuOlYbYxEljIWjaQzu7Yqrhsn8h6ZMB
	 ZeEJrepGyFEItyvNuvPGh+BSws4DjDuQJ49yyI2XfGBNAUx6a6uL33jRBk0t4y5cTFW6w
	 VpUpmq4JeadW+Fz8hqfdzMSejBhKrUpAPi6/sTGMpsHABfJCYkhpT3HciGoM0zcqrlC/v
	 5ggBYP8crKQ/xbrNcMbA7rVy3JXTxCkqGdNyzYvIdNPFbj0GPpTl27Z1dohX5qvwJXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXwA6C2X;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81789606A339
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 00:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81789606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXwA6C2X
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so52952c88.1
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794531546; x=1795136346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
        b=aXwA6C2X78/aErlxdCDVlDcBhkVNyzQp81N3HP+FcVhJ/FM8Ts6K3OTLEdrDTNlTZC
         PZlGbsKqFdepUhhUwf0PTM4/12NFZOmop3SMoBLlrEo2OKDYLM2AQ+eqSG4n7pA3N1pj
         r5tFkM5LxFCtgMVGCSfAjr7e5Ubz2hvSMv3cYF2jhO92/gHpAxYLlGhuvE8Oam0NBvBW
         3d/2C//L92CiXCNnqw6r0R+4t9XZfGZjwz1VoaqfrCxDktj2prFI3iKcjRF+UXFn16ap
         6K7zLI1kvvv7cxwwJV6+lExKlmTZf4DnCTPEVPaKT1VACLFTNEai51iOa/kMF+qrecyi
         rbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531546; x=1795136346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
        b=OnT1mc8uIFQsJh0ej8zTxGlzmSnHIyeHiwUrMKrkLcFysOR04sZVl++tMmBDtte+aQ
         dVYUbmdVULDr3kevmrB5q7aL8ml+LiBWCBNQABeO/YkB67YIjbI0fFCVmm9JFoRvl11e
         QZ6wXXsb2eXHwyf5CCvFdFYsQJA+ApxozSSzyJMn7KbM0uOhtao9fTyR6IL7emyun0wT
         gBVmYMn9kqdRthQ1k8q52sNIcqv7ietsZJUmdKVSiBXMOymSfQKCQP9fLFEpQhCuMW+F
         nRKnd9zz5kyW8/RUozl1XfqgPLDD0lmkugktC63Osf/XNBZCFPfAYrnQ5n5lIT5CvwDG
         WgKA==
X-Forwarded-Encrypted: i=1; AL+hErFdMpwdWWpuq7EXgbAzIGQF4nKVG9qeIeXugWjuR4gKmdNyp5QigMJkGoiHbv3aCtaYzKuzmh/CVAJzMaWoLg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/bcF6Q6A3uZthC5OAA2fqAxd9zAB05F1xkwCVa5VsNvIoPARuf
	YUAav5H+4c1fODcKFHBICJK7I5aExniYJPHwvWzrjN7h3QZ5z6anlD9G
X-Gm-Gg: AYBFou2BHhRKASnFck/uHjmRRYSSLKweaCi3o/7jp32hOLwl1U6YJE3922QwDV4XNOl
	LEWVord3K6ucG1JeFMzwRGSG2+HhUn/ELqxFBwTItLOtyz5MHI+5x/FpvkfRoF61jf2cpGsH8oM
	FJK7rRmiTPhu2cPAfWcOVQTrMimhtOItpUjLlI0V+DkR9Feq+aMseS367/oWaGc78Ib7mV9FRwH
	SXymC023vKcZByNCzydC6T41XrjOLH2cnOLBWKOK5SsplKuQpeJX0Ko7y2oT6nGkCPY16zd/Rjv
	CXonGot3ZBQo+n7lFk79Qyqwz9cQhU8p5sdds3z9mChbXYeNuK9C6QUYIBWWrTTd9bw+iC3VsCQ
	JY5ZHzkX/yHOUs4NVn/6EThcA+ClUWBpy8tJbv1+hj3IGYWpVVESJf0igri6/gHDhgb8Guexhym
	jMNlUX/VwCwVrcKLtw/OmsGzHl6O2Zlo0I1G9BmWqTCEHTsYEs+3kSE5Mx8x5+X8Nx3tjJVHBU1
	wE9jAUoeoRgIPuC3CDdDY1gMCmSqxG5J/dU2iN+EcHu7WnvbQF2FRGOme+lrp+K6cYCS5A0rS1J
	BjmGHQhwYQfveIsbsTupDgim60B05nxKwQt2ldPKuVuzgqSbkh2ogOBmgw2bfHbQhqCWn2E=
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id a92af1059eb24-1b5030fb74emr1197809c88.19.1794531546379;
        Thu, 12 Nov 2026 16:59:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm2760431c88.8.2026.11.12.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:59:05 -0800 (PST)
Date: Thu, 12 Nov 2026 16:59:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 10/11] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Message-ID: <avZgzxJtnMceNQnJ@google.com>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
 <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>
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
In-Reply-To: <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>

On Thu, Nov 05, 2026 at 01:54:14PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied, thank you.

-- 
Dmitry
