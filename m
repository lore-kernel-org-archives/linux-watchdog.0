Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389744;
	b=tJDkFjq9EXn23NwvQjzOHvALMqCAOe3x2tzrEQaPr0AbRV0l/WevnKiYn5Q0MDYXpooL
	 mXZBXj/CL5OaMCGYmluUTHzVtUI2faf0K2z1ahMLqEJsmWH/JPeiMMe7ItNw+EdtfDBHT
	 C+wce+/ezqlWtO0xZD67yaESIc1hT7y9+1j6ph6Lrv8gMX+9IAGL37K9HWYYObAjXX/at
	 AHj6kkj4lds5rMiUlhZ8E6EYADKfmzPMCB+MoLPMfrjTqQcGrXZ0VPpgj1Gb8Wgjk6x8D
	 lM//HpWAlGjIatC29L3b7nvEUKzHP+4/GdKfwK62OKDpiRoU4hnzdSwXSq9r8qxMWJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389744;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=Z8g4xiibKWQuuJs7EMwmXcAQgq7/Z7zwBqVvlgwyNzc=;
	b=qFpBgC0NLWfBae6vy4KIyckiErMumqlEkjZFTFyOyQ5At+YNztnPEgKJEuOm5iVJsfKZ
	 XUEzsvxW2kEUXPz5g17ND1V7bOPwS5Kg29UvRDkvtKWFB+yw87CQ4oQ8YM0NWidSnPKZm
	 nkKTMc8BqKpyizooi/aRAXeNs0wwTnA+TJj6kSgvZ/f+b5YbrmWq4jyxo61SZxXXRZahG
	 t0DmX++t2t7fmf8u8ahJotxfVmzAWqvxvsIFgaVjjEUhA22PulLsPF4BPmr2RwumaEaz6
	 Gz/JLj+DTniU2wiviB5Q5l/xoGL827RFOSZe/SBXN6ZFgmpXQtink4r/uG7f5MfKY9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=yPk7oTaK;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FE606A322
	for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2026 19:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47FE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=yPk7oTaK
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id MeijxnmcrJFmFMsb0xqu5K; Fri, 30 Oct 2026 19:49:02 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Msazxgaawe0duMsb0xJWl4; Fri, 30 Oct 2026 19:49:02 +0000
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=6ae4f4ae
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=3OfnbWqpRXkE7MXKp-4A:9 a=CjuIK1q_8ugA:10
 a=AKGiAy9iJ-JzxKVHQNES:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z8g4xiibKWQuuJs7EMwmXcAQgq7/Z7zwBqVvlgwyNzc=; b=yPk7oTaK9jPnNUqNMPC6twzpsT
	nytbZs7aIA1qfH8e9yM5XmhTrSl/cYbIZ9RliN0XK6PH+8fH6iMHI1gCwt/eOdzUc49xyR7pm2jYG
	R9wLgSVekO9zz7XW1C3SjWJ2jdanQoPmO4H3xTNiPdbDJTuDCzQpc8aBllvgvys8U4au70SjQAcVr
	9kcENVpW6s4Z+c++LnSDgqh02SbHMxe8Bio+xFCpQVb4Mg/zNG/QunFRcwYu/SoYh8Aehzm3qPknX
	EZ4s/wFn4ZXU94FbWoY7yOx8zm4QD7ylqGwONkzT2WrVTWpzZjoPkVFtX5kt1BNNAWsdLe/GcdbYI
	A7exSNtw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44054 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xMsat-00000003tHT-0RvI;
	Sat, 31 Oct 2026 01:18:55 +0530
Date: Fri, 30 Oct 2026 12:48:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v7 03/11] dt-bindings: watchdog: qcom-wdt: Document
 MSM8952 watchdog
Message-ID: <7ba73247-d832-423b-8020-21cc135cd02b@roeck-us.net>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-3-ad748ace375d@mainlining.org>
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
In-Reply-To: <20261030-msm8952-initial-support-v7-3-ad748ace375d@mainlining.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xMsat-00000003tHT-0RvI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:44054
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ5x/kVfyk9ZLcohWVgZ7JYfRLJJrjYkRmI/2Ckc/R2jo5StmUBP7jigv25ArI+sDaF2TwK3zmDYGPRoFzkPk6GvdbUk9yYVfffkzRK/l/n+GTL35/GS
 VyJ7FS+7fd9Iesc/TAJUHmkRkAz3GsdLD8YNctm7lzxDgLEBo+Kj8r3yTOnMP4k8LNTryhNSpFb+gBvVFYVko7zyDWarnR3dQ81kP2H3Q2fzdMdcwd5L8oN9

On Fri, Oct 30, 2026 at 12:02:34AM +0300, Muzaffer Kadir wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Document the watchdog found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
