Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623367;
	b=RwMZQcCIfarbslQWqvmi09tBC0o/vdXr6ZiaChe8jFsNoZKtSg1h4RAIcf06ea3M1ieY
	 j4tLkGI5Ap5C5StGDdXO8ZH0L3bRaaDDauI/lAt5msH3MOAROB4Z4InIcnsm8XpTY482H
	 1mJXenS04aEC1wGckyaZzduyBb5ORKz/CgEQvZJeyL00tb3RdHDBD8BGzlZNW/Ekj4voQ
	 zvj2T12RdDEhuIyAxr6FQts9T/RauAtm2R43ITnu2X3avsJwoTO7AYKDE7yLp6o8jkK7t
	 1kCpohZB8lqRX9loyNE+bUUlFQ2nBxXSaNcGcxLmncvOlko8wwXGjztUcTHt4qA0gsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623367;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
	b=J9KZFv3P6cxoazjXy501sFM1TKF83ByPpQjhPoFgtQI4ZCjSJzZnQc3BaerOTMxVGtMc
	 yAPGx8P80/zhIhJbvLvdBBP4aGHjBgoG/fbdRvBZhDQISzjrwaWh5sM8dbryuOFzBOlJH
	 LWs+2L2LaWpJbkvaCAOIasHPpxoL/WejSbks9XI0uB0vpwpfrKki/QdbmVpRhRvNwdtX2
	 4Jmth8bCY8yVqKl2ImSXQzsLs27k6TGnBRD0ksWUsKLI77k5jJ8Abnx2p/WUfhGDD2cM4
	 i/dwQ6GWEXey5JnT6oh9akq00tbUAYJUppTiAPJ3hAvgBPeVuzvQiWzsWd/8aHi/hAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCXAe2dL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33303606A331
	for <linux-watchdog@vger.kernel.org>; Mon,  2 Nov 2026 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33303606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCXAe2dL
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B2vbM077082
	for <linux-watchdog@vger.kernel.org>; Mon, 2 Nov 2026 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=; b=imzn9mgE7jpQF7UJ
	l5NhN9P2tCVnLxb4TdTBR2FOSNJYdj8wTOT26//AF1GPF5PuPIQFSP5ViGDCvCa2
	4mmGrgG3D6wFmc0KCDipUueSrm3NRhQkBzh3GoNpLwmwC9BYu7cq7Ua57vaYcUdl
	7YgM3f7Fj1J108Q1ZgoO2WvAuWPIwY2sapviVFR5lXCi3+SLKGXIo/izg2gXY3oL
	7iTbK1ENuliAtSaY73WLoFYMb56uptzP5XHbepiephZGbLxaLYsO/JhzEU4QKGII
	YlJK7qieMGwQeYo3B/Q8gJ8RC+Ywd4G10lvOIH5zpCYXkTkGoH1cH/FMvobYmo0l
	TdgZ3g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6rb2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 12:42:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7fe5576bso20579366d6.2
        for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623365; x=1794228165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
        b=aCXAe2dLx6AvaA3Ui7ABcy+OyV6uebqnuOlRF+vCG7XQ5sOZCJbjH38nn86tQ/NYsD
         YYHpQ0CWi+7ui8DF6l2AjxJdeI6Y4UvnZQtB3GAlb77QbHRCih8R5vYiiSauBZvOExKP
         2jH92wiR69s8RF7UfIU5k9ufPo9HtEVpRpWX/lgyVyGo900JuD1Cjp70VmCU7/praxrP
         nx/03JbllRjZT+mXWgHKTTSPJkgJMS+itfhFm2n5jS2MEg+B1iTjWmpNXUw3TM2TKK0b
         pVUNtw3RqR4FaHbd1o9f4BfO+pCy/y87D+jgBkDHMhZCAy4S+DB9OKwpg33wHyV8FkaV
         mvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623365; x=1794228165;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
        b=kU/0e3qhn5m8E5w0xcedaJyVZJ9H/ZWXsFPjGkkal+jW6qRcOtC2KEDNqrGCO0Z7yp
         293V66k4K90XP+6vvNpFOYx9Oz4LsZIbY79sb9oKO7XtC/xqD1NBe59rZoYUmdipe9AK
         UTaa+9amu6wqA7/m+k/rsIRFbU+Se3f3RV38oF6UdW2tnxPCCmMXpzsBuo5FQTg66aHV
         Nlg3x2hYN4+PS4cuoyanYugQHAAEO6mJlPnEa8TzMvpFtsPFHNESMjDfYoqXfdWzmbXW
         kBPgxMAbXtphHOiH3cNJTF7zQm1Lfnjwc8mZbtZjXUYD5hjFPr3lU70PVcFSnBKTRsjg
         GD9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzAJqOyH1pbJVw4mf92jBgC77t5ehmzVKSAcoa7c/6AoINLnLJMZ6al2IJvjYIiDQghklCficbAaea5tprc/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKHnFUDj8TG0ECbM0El/kn0txhNryM+ljo6y4fGZGDBqupGUzKb
	G1qHvIkDduQ0MjFNdoCD+NvHHjBsWBb+i0xVHrcAKYzu8vmnodzGDbP/T9uCU8eSXORApSyPdir
	pRHmPsPQz7rTEpU+A3vhmysiPPMTwkHaH13++80cgzgBOvumO8SPYYTj307zOcmkc3xLqUA==
X-Gm-Gg: AYBFou2G82pc9shPrdVjPsRkHnmPObmLKPWEBrzllSIyLqgoZOcVlFdhwlEHLzYoV5/
	+42/4MThxypBmGOG8EChkJKK02kZSGNovI4Ke1KBHOpvvKYntvJTNi2hsANChNMMsqvuX+6KfqY
	s2kJRNOVI6qNZoIphZgr9c3oGTWUxAdw2jZJIc1Ja6Y3PcPrIjv4bKkE/7Hlfxl71CQG7gqVgW9
	1c9ntS14518Q2ToLy5hLpRjrva6/zmdR3r4JrKBPuxNBcbcIeqTD17apkvwnu+VXJyJ0LsKGGYM
	3qNOPVu20leL5RQZZ7HpVpxLnOFI1RMpYGeXljDoq9H0tW4F4mXe+3WWtCw4I6RqiZiI1CcirYM
	EtrBgJPoCKV8ushRTBNpGETEN18CqC/3lZ/tR1eo+yrPOA0e+gqr7loOvAFKTVX9dZx1igVo=
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1608070985a.2.1793623365478;
        Mon, 02 Nov 2026 04:42:45 -0800 (PST)
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1608063585a.2.1793623364967;
        Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18e78sm399183066b.9.2026.11.02.04.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Message-ID: <99023059-0d9f-4ad4-a861-299006ae32a3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:42:40 +0100
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX0kxBlkbXoSDw
 NOQ/8ypXluf/yyQzT5yQKUYbuR9FZ3+dLfQ9vto+WBECxKMYZL9qVtqDGYNLlCCAHt9UMpLdJW4
 2VrZhbCAiymtgt7IW96aWjRGjucLl8NikXgw3AHruc31WH7cvWT5Cb+R56Q1jBcuBZIGig9FhFo
 lkB0lIrCoxMVuuXe5ZEB/jNmKKNXZEpqRJC0zDqmecWNoWwFugXI+ZSMWWYDVpiLj78w2NlDVs4
 HhKBmDG/nTuA9FWGwxoFAu6SGVs/Jcb9qT+dOVQmheb1Tcv5HHonho6tuTOhTjIjNYAHjbqfmzw
 uFQ7+KL6N5IdMeziEVzJng1u8TOakJwsqrF6LQRs7IwEWNsPAZQdngEj1h22S6saLf1FYqDMiLr
 PMJXre/UXVvuVgjPA19W+NKxQRC+9XEP3xdgSP/esxaeApmljg0rZ8NJmumIHLn8SH8pXCDNX7s
 PVbELMMGYM3BuJritdg==
X-Proofpoint-GUID: AupaTYlwar7QAxjdNStBvVwVdiSzCspb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXwX3+UUVBqBgQ
 yusLXABV1E7inF5x7CR1hNoF3YaRFsLGSnLrWdVeup0XV+hX9l/d75yGe3zXyryw+5j+Yus8afW
 GzN1V7x16yY2FcebYUJhiVRLcdACyKI=
X-Proofpoint-ORIG-GUID: AupaTYlwar7QAxjdNStBvVwVdiSzCspb
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae88545 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=OuZLqq7tAAAA:8 a=pjH4mUHWGEoP9p1cUU8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.
[...]

> +		mpm: interrupt-controller {
> +			compatible = "qcom,mpm";
> +
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +
> +			mboxes = <&apcs1 1>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			#power-domain-cells = <0>;
> +			interrupt-parent = <&intc>;
> +			qcom,rpm-msg-ram = <&apss_mpm>;
> +			qcom,mpm-pin-count = <64>;
> +			qcom,mpm-pin-map = <2 184>, /* TSENS UPLOW */
> +					   <49 140>, /* USB ASYNC */

USB DP> +					   <53 72>, /* MDSS */
> +					   <58 134>, /* USB */

USB DM

> +					   <62 190>; /* SPMI */



Konrad
