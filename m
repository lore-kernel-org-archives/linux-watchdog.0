Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623469;
	b=hiEQTsJ9o00dUNX1pAcSPQykS5IIxp5mgJYiEKVZIaiKEgaxUHKAx+KGs5eONmmCnYg+
	 MrXJAutzHjUSZkT3fXIA2QBsUYs2azOQSE+QCmas1VLbUF79uTJakuIQKzHrill4UMcmG
	 6K+KXQcVAY7Di4NJlhPQl8UWPQxrkOglHUYiw9pvEdQMaSpS6hKZyzsezgyz+T+IRxAak
	 Ur77PT4oqsiiwC/qbnML6zYhI5STgbbOEzwUTS/1+qoXX4WM8v5w6TMD33mytHkai5X8I
	 h7rO1fY2gXg1ClYyQgSXn78uLZjqGOyI0nTh6TpfA06PYP+EWOK60wnoVFYwegOOIcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623469;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
	b=gLpgb6PiAZibuqf1y5kqFvry2MdCGs+ZUK+3Ygo2TKySzq3ZxXH+oy9JtfIzd6xiG/F1
	 J5hU0X5ZMneZL7BrkHmvrchmsVNjdc0jAQ9gRJa+1t3af0KWMzIf3pOCLnb+zenjusGZz
	 ET586BSCyNxcrvjgd0X1Bch5zauJWmI9zmjXDaKOOgRRYDj16Q1jpJtfxirZHcIBT8ahh
	 DdbnaYd+ZFTSqSWh1BZMglWBcTWYQ+z1iXBigWUAORDOobWIW5wICpLAMJMJQFOEvVIwJ
	 PQREz+HZo6gT5LEdIEwzudfygMee7DAPcjhttgqLeS1W3PskMtZYf9rtjFiaUz6oeNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7QlGTJT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7C60A2638
	for <linux-watchdog@vger.kernel.org>; Mon,  2 Nov 2026 12:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE7C60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7QlGTJT
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29ADwI4039486
	for <linux-watchdog@vger.kernel.org>; Mon, 2 Nov 2026 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=; b=EOioltV4rTXNoKF3
	ipmP8gz3lEBkTW5wy4eLvI4Uk9sWVyL/sio7Fh0GJKxk5fXSaL0VhZlQ37M5gKkl
	utI1djX5mcfcMR2+HBR7ym00h560mBPHQ18bsMi/7RC38I0QdVzzCaVslhFxPB8g
	WOQ8v9kMSmzZEf1Jp88whqKbJ/1aklD7VKWlFCwzgWhsfVoWp2Oiw4bKNw404hw6
	HfrnjxMrD+UPUO/PmrzmEn2hqobqG7OY2RbeXRZ+2UxMZ06IrUJGvsgmVvVdvgaB
	C2SVui3qlW+SumQ0SbJk3E6Qz5H/SzHMVgy3dcp4nnWhlThLJ6KEXmc17CFlcK+f
	ur6lYQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph195gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 12:44:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-533962f6bc9so6845251cf.1
        for <linux-watchdog@vger.kernel.org>; Mon, 02 Nov 2026 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623467; x=1794228267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
        b=A7QlGTJTg1R7aVCIxrZBno96wyT57p9MR4SyTVob30EUPPSoSOrERvCYWxWjWVfxtX
         vRfgFikK0k5G76xM2d4jYhiJymFPWnXigQ1jPCl3iohwDdiuO2MttOCSMRve8gRyM7Mn
         nhB87XZnpJqf3ciYGDiP7t6AUdFmZWBM7hpdN4L5qTZBp45kJuVLplZ1N2q1Ar8CSF9p
         D26ml7GQzQ3RGKyZHBgso6ACO/zP+FuGRWVGvM7B7sMU8ziPFRvxF4D1uEAYX+lVnuHg
         HJ5ORisL/e2+33bdKsNvUPtFIJTRXbMwLOyRR3L4NCJsQYP/l8jLef0Ele42dGrM2icI
         ydaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623467; x=1794228267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
        b=cohCb74WVWaAopgqsxKesDh70bryZZC/axv163CKzkY/7j8n/q6FD9aJLEPn7THEas
         kWXHkUwU9GPRZpOAud7Btv9ZYYbL6y19G6mfIl0a65q1UKWH3+8Ww1BSe4HbcJFYnjPJ
         l/vBLjNbsCNvx/A6TyhLO7VCHXs5kUkuQJ6Uwp/juXG8iQ1zoAFYgPs+yAHPzqnOXIwJ
         p7HqZXBDlOuo45yfTXKicx4NnAu7Ne+j2648sLZ4neoom6A7HTNBwy6RdJwbxOc1JjcO
         jkpGVeygp3YLQMEFRGXzNgK756Nvd9g4l4CPeDsm5/QkqiaOUd920PxRhDpJqH6Ce6wF
         l+Rw==
X-Forwarded-Encrypted: i=1; AKwUvBxAwIyD++0MRj28hHuYFdOiNjI/ycP3ekVKCHGWQ0BYR4cAnA7FGvVv2koZawJUYnQZJt2IOxZ/+oHJ514mGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKV8QeyRsfrePcN1qUmNfuCE/nNwfBZJDM+XZ43Nj98mzJmUMOF
	uYXJPvJyu0JKxsAM5SXrN1FH4R3HJ9uID/8RzRO8RiJKBJsWXkA2c6fQGXmtkeWHBkSjR6BQuSp
	DlC8QMBYIT3vB6W62teiOPIz8NbILNbOEhE+1lgd4OWbL9GQXdySE7VgVh/YdhCS6N5puwQ==
X-Gm-Gg: AYBFou0EtETk6VqmA3kMUo4tKM7TUG06Dj1gRF8Vo8GGbJ7CjkpmzHgdRKIWv13g6Ag
	tSe+nh4ucNIB+mPmPhx1QBmhvarrwBYZhSYrqIZNYgr1/e7VdEJUZzyXMM/+IYCjcH8FB6V68NW
	gfbibbZdp9TKz3SX5Ea4hPS5nqNKG45v8IIUV6RLeDvd3BCH0QIlmR4/CyNaelXTs4EzSepV1NQ
	FlHpa30YGj18m9VHC7cvzoTy2/9FQSU546XA8zsLHEOtKLJz0LCW7f3e/gWLINy/ycZGQ46sJIH
	VKfVim0Prrzzq6z2+u/LoBcL4WvV0goTo56n8cRYJjqaMRePc1FTap+ZIxjulR4utSzyAldOJ/P
	+rY153jqUCQC5yAEsey8I5VYIkHJwa1u3OwJJwC81xBzYtCtwXShNAgNza3VOCbr69iEJqkY=
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1564910685a.4.1793623466931;
        Mon, 02 Nov 2026 04:44:26 -0800 (PST)
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1564904885a.4.1793623466454;
        Mon, 02 Nov 2026 04:44:26 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe101d4sm389225666b.40.2026.11.02.04.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:44:25 -0800 (PST)
Message-ID: <73f05be8-6335-4d48-87fe-71ba5fb1d2c6@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:44:19 +0100
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
Subject: Re: [PATCH v7 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
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
 <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KNTC2mM4zKVx9LnaPa1jx0jvZduxG9X_
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae885ab cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: KNTC2mM4zKVx9LnaPa1jx0jvZduxG9X_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXww/UPi761H0s
 G5n7n20BZqaPwftqTMmdgDT7xjQfFih5EV+wF2h741e1GMBdOsWnQvKkBhGCJlgUX6hbLPm/goF
 gpBg9F+4W+9rR5ZtZgJHzNmFW+MDyq+mRd6qHuMd6amCeG6RW0NO5Jmk9lcaUXkAhsTyhQf01cL
 jRuptJmLlLgtSONqJUHQ8+HuzgIVZD8V8jCcukNU0R/kRtQ/iNxKZsoz6bhwaGbkRqHvSlFEQbc
 XB3fEI4mE5AHdoL8jKOLuet2FkPONXY4P/I2beLuMUiXhMwPShxBkBr9qwiOhvj1nPnJS2h1N89
 mYeR9LqDPcGOD4wCf6FRj3YU3Jy8Ky/afRk9upd1ioQY7ep4QIMP9phgoA/7qu/KOEnXi2VICFU
 /2VkwloCX+tg5YUzVr4O0hbYvD7XRLSLWPBcPEtzpDDSuLDDs0zCg/fD6NChpsgVkoE01JYpt+K
 X/LOHIuqYpQHsesv3AA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfXwwWER+eEbN+5
 pH6KYkruKSXPH+sbeTQa9Hd2uutP3ncWrvpHOSL26q2zhj/Vr8L8uqEw0RVIHmVEkc+I/S6laHi
 I/c5m7alhOqBS7jkri1Nv8RDRHpHepM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
