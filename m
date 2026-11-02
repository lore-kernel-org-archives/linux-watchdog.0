Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623160;
	b=sFOSnF5ANe4bMLmMn7xgIBhwzBNB8j8mqI+j6dcahzd6X3rU8XRto8qypZfJAo7YCi1/
	 n4M8OaDEx9lRBSFefTVcBh0dOn74Kc5E4v3qf/wqBILFg3nVaCAISk1JCcYIjpZjFeQP9
	 VnPp1MYJ9ypIzZzBzgdIjcKd/E+1ImmRWNQdkGqQsG1qNaN+9JzVBW9zhvj1K9KIms7Es
	 S5F0W+mOxcR1Yz4sqZNzd07LbfBlxjbanNdppIOWRZfEbVS8pOU28gY+nCVPuV3Vnn6jd
	 B0mWQ0oq4LxN74Uhq06mCM9HqnEez3wCzC5q0G18cqVMOjkpotTJL7/8ZW5CZduuRbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
	b=ljShRXMuwoQG5irT6Gfr8bvX7MDOdXBYnzP4fQ50dqvf6H7tv39/zS2W9V7f1tf2PNUD
	 7AeMQCTTtQ9iWy/QXBIoQMWO2PpWRxr4E4KKU6F6JlYioV5S5JXkkk9VSshgMOqyvZUoD
	 w7x830UyWABKBlGXOnjah6vJj0oVaFgdszGfwcgUL3x7xDEpFgQFDXkcekYfrevgp4+xT
	 nLMqy25Qsf8bQ2eZBa2Tt8vUXWr3peLWg7rjpPJAwhBEfqyo2r2aCr+uyzvgMBlfwFbYO
	 iMsVrKBa7aEmIkaSVcY1fkyVnz6czErQk0NTTJ7YaYSWYsGlgjntOtx2z8RUsCcrsPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tpnfups2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD82606A331
	for <linux-watchdog@vger.kernel.org>; Mon,  2 Nov 2026 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FD82606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tpnfups2
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AMoL1821127
	for <linux-watchdog@vger.kernel.org>; Mon, 2 Nov 2026 12:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=; b=o0saIndcVHp8vZ6f
	CZ2rkVhjH6ouSd/s4V58y71yXm80mPHeAGEZO+CC0GP+LnpJ9lCUFhD7KjU0mpol
	LhVJHiTkF72NE9l1LmUq3b+c80HrkvP15aK90GU2lJB/zwQOfZqylENqYUtyeX3T
	AU2f5gRStFfAqYDzzvyjk7lLa8GfK7f1LNdcYXLNO11BPKqQtLcgkmyZ8Xpsixgn
	g37lQ3M1AHJJonE/at+vRCNLpPUe0IyzOUE1/wTnknCOiKOrUGj9i/319/V2CvHM
	KJxzu1UhoCsqrbX7DDFAWEqBWoRlU9cGIIM+8f3H1kFlqq0kV5l1Wqm0ffwKkjQG
	GNbzDg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hpbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 12:39:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c99c10e33so7991836d6.3
        for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623158; x=1794227958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
        b=Tpnfups2+QSRVb7I1L0nKeK6XuBUsdWasskFT6gz395kizEjfAjtra6zsE+NL8Py1u
         3CjuXVj0dZYKlzPxR/8yRmyRoapKU7vIliy+5Y9pHcdngkK2UX/r+TGQRWK2Quk5f1yZ
         B2qE0aJzewN0aMeHsK931S3AgGDOf6Ywlfvx+uK130x9MTvo/RPDbhp7FQokaZeTfBct
         ugxJjtSyhI3MWAJjD/RYVAE9ce+AR3mXwTqRer79AXrK2xeTZRvFpDCWBzInAO56mZKN
         RwY5TtYITH8d1iaW4BEjKwH4SFPuBoyxXYPW9BLlPZlisegm6RUArGKOrZlsAe5zC3Dy
         rF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623158; x=1794227958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
        b=cVxcSPr5ifCwrMywROqOQIXTv4wU+ugN2Rai3fxGl3p9AZgv2eIN9Kks0z3Op+kBxk
         ivkniGCf4wkvUIUrUTVIQyVow26rhPnaPflTWVknTuPpiOaNNPO+vkmvx20aAk3fSG6q
         krMIzQYkmHujXw2t2K9AzdS+dyGEd879ZdT777Vo1p9x0BNH3fTNyjlzutrHKHlYrGZB
         ZgsPqrzhnoN1khD001PNBzBiaZjx+On29f7tZ9Bv7S3F7PAxXn8zWRUCUJQPVdxAE5mD
         RXMZcvlTl+ZlWJ753BKeA2wXHv31PL/s9sX/bFUu4QwuiTK+enKmxEVVD1vuSBVsHf6m
         bdyg==
X-Forwarded-Encrypted: i=1; AKwUvBzy9mQridGv4tpqXdt2S/f4rlXs1b+5RXoCpQpMCpoaOB2z01nsJ9XyEGH0DSPTL92nGzbUMLnWH+rsUJJ27w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJEekpMshvxT3p10FQ3HEHdwQufdtgwnL9HJYg7otRRNA8S7gTa
	dcJcgIpdEb1DCqmFEux99fM0RvB8dIRd4r7hZ3AdLFRyp7wmWiP/oGVCQQ7w50Sr9Qe0z3BqWVo
	DkwDkoLi/kN9lMmcZdOI6QDyyDEZ3V/pVXUDXotftbBngLn1GouEoUmOzvVSGnHyjTIBBCw==
X-Gm-Gg: AYBFou1SxcJqqRXgJYEoEM+IFIHRK+JXC4o9gtdKybWX7gqn2RXhm/j8e2jf9DUT4Lz
	jVRpg5oqdkm9jlarnyiNe9wOpxWr98TphwHSDlfNn1mnbUbaN7kmqdx1DKwwXGmUk0eECN7zh0C
	28i0fjGzM+5Yp0y7pJuqyS5Vey5EMe/BjZq32Y8+pqrkQvRZADJx1zbDar3CrAS3d5oI92GZqb9
	QcZIByD3ACta1nTYyq6xYVq3TRwNbnGc68aww1ERorPprP1lJ4aNumUjl9kyeKkuGBmPTc0ih7p
	/ByoAiLNoDf0L+a8q8+Cz/2bODgH9/ozETHe4jLDT7XkFRcJUmTWFaSh5Ts9SHHJWXcJexqyBMF
	cgSO7AWUXiR7auVMnZKo6omcYq3DE1jyn9/5Nsqbhz0SlRYWa6X2gHqPbs9aM2Zt5hzKxiJg=
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id af79cd13be357-94421666fadmr1815611985a.3.1793623157874;
        Mon, 02 Nov 2026 04:39:17 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id af79cd13be357-94421666fadmr1815607285a.3.1793623157435;
        Mon, 02 Nov 2026 04:39:17 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbebddacsm23222831fa.6.2026.11.02.04.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:39:16 -0800 (PST)
Message-ID: <ee443167-963f-4a12-a49d-0b4523afc14f@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:39:11 +0100
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for
 MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar
 <jassisinghbrar@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nXhHaJ_-gHdcad0Cy-dR3wbpza-tGuuA
X-Proofpoint-GUID: nXhHaJ_-gHdcad0Cy-dR3wbpza-tGuuA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX8tcdioPoiF/p
 Msj07qrRkMqeWbYnXHD/eFFIH6ExAh3BDKx21p0X0wNDO+TPY6OUapSZe65M1RTGrfdCL4BMTXH
 MeJ0s7HnEBsCDAYZmKgTuG6wfdFLrMA=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae88477 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OuZLqq7tAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXy4K85k+prEv9
 aWwMFRlYhvP/YYyOA9tPZkPxURGUA45eLWqA03sXCRxjmzLEQS4SStaZkI6PNR6DZKb6/m9ROab
 KVonaxph2OEe5tKCQe4ljBLDr9ETeraXQtCf6fqVnM392dl6CkppPn8D8D/94+EmUcysBtdJnbZ
 6w3V35cbT5pinC/1d0y8upq/uYn30AoiWMy1Fnm68SyZZJu8CTdr9mXDYJX+1N87lpRWy9fZ0cd
 pGqtS8WOKjFNnC0hQGN06FCom3dgGG14VmlTJ4NCHZKTY+uGSmemVIJCC+ROYfYxAGCy2aGC4x4
 WoSJIi7kr+cxeg7MxnSAqBmkliGRwoRXT4FnynuVEtsL6Lgfx/gSfslaIkiTc3kYmnOU1Yaz6Eh
 A/Q0AF3lbTR9zpZRYE0lmrAV4qX+2aPxeActMTy1wP3g1k4Dss7Xy6bisYG+6dw/V6zsl9fCxC1
 DWxpm/5kCF2WN/BHFmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.

[...]


> +		gpu_iommu: iommu@1f08000 {
> +			compatible = "qcom,msm8952-iommu",
> +				     "qcom,msm-iommu-v2";
> +			ranges = <0 0x01f08000 0x10000>;
> +
> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +				 <&gcc GCC_GFX_TCU_CLK>;
> +			clock-names = "iface",
> +				      "bus";

The robot suggests this is missing the TBU clock (and also
sister iommus)

Konrad
