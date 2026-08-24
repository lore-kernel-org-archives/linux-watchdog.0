Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18113F1660
	for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563037; cv=none; b=EygOQ+0UxZ2D3ti0NqGIZHMHXaRw66UgCpeEg9m7MtYHhynzNbRZNaM7boBYJo2pSJkngwQdVoJcoXl1bq6vDtxwDEMUZ1Jq2uYy6upM1xOQ53ObTTa+3PTkLy/4HwRdhnYP6czfOgK6TNXQKJBBkOd1HJBvPIadb2c51lScJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563037; c=relaxed/simple;
	bh=HY3quUIZFTbjvevuitlFBgXCQy04pa7QPQrGbVgQ0yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFoV9kzpS3Puz5gUJUJmHDm1/X9t/xcg5jNsT5PZRZqKaVC4QnYhLnVnDnpKVnRAq01rooP4WATdgHRH/HyEgKK4ZMNgtEqOR/OLmqtSf5sglxs7vL/562gkvsIKnY77f9EwYQ3xA7gK0heBD0dyw8zgZtovAo3aRDmG5XG/b3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HzBpy6bL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wz98jR22; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzBpy6bL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wz98jR22"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9A3qh1510216
	for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 09:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m7lsraZhCPgC1BRKXbcGaxnflmdJRncfoKjV8SVGtLg=; b=HzBpy6bLvxcKobmj
	kjeekBmBj09BzR2IySij75Pa7rmheFJ2IPQEeDK+5cEuAijTDifdPe3hssBmG1fD
	eAWwaq3diN81Z7khCN+eP/JM6x07pnxYMaxY/HztC4Ya8VSe4kVc8lgDtEbzk7c+
	MupRD5LQBlogcQVoFJ1dx27SBngWbiHNuDAqPOXIRfhqFitB15K9yNcIkmltWLWc
	8x0cjXjeEpqH42MGpsvR2ie1i8OGXNoNfFHaXVJVVTlLOD6nkh7+uUBOws+sebRW
	u7TNkQgUdmUouf3YPwLyvcjW8J8Ae6xYLd5IHj7LYSZnfcWm2fzMku1E5qRM5tWh
	5nUhpg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhe6s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 09:17:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so13000415ad.3
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787563034; x=1788167834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7lsraZhCPgC1BRKXbcGaxnflmdJRncfoKjV8SVGtLg=;
        b=Wz98jR22cKjFjFAwQy+ow/UcPOuPwSt1mVsiJjltjt+WehBP1/VGzVwdBR5UTs0Dv/
         86W1bXp80f4bxAxr594G3t+eYQINYyDSPY6KeJI3/2MmuukocWxdja2FNHZh48AAG10K
         wDovVGlgTvQWqdfVBSmokLUNAwZ/TRljuMmwTQd3A+LdtHFv8SRLiByfpA9VFoVD15dU
         ySDWj055JNwaNrF9Sc1mhWgpBAx3X6o7mF13vJe+llwGdSOok/ZvqT0puUrwYh3VL6DE
         GGCxC0UaOkeOo8NTppR7QgnUuuEmX83L05B5PivAspdq6MvbPWGyy/DP/ZSsYVNa4HRN
         qKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563034; x=1788167834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7lsraZhCPgC1BRKXbcGaxnflmdJRncfoKjV8SVGtLg=;
        b=idM5P9l8rsvv15zSYOSEc2183nXoGGa6Rx+wokk9FuhOFX4D0gtceK3OL+n7AiVPFz
         L4P0a0oiyKclYAKtSX1xu1j1EG7bJ7cVIn0HA80MCe7rPCqPYbQZ7pbNbyBbnDITPy7p
         MnzF5dRkh09x6KZSAdPX7/XM9YBMLJBOkpd2FIwB15FwGb48ykVG1i2PeeUmEC2odijX
         Unx7VWNeQ39giZ0spgEBErfq8+2s/8cmXxXRVL/7kCE2nBtPhWXd7L7ZrjDRtTezRgf4
         f7LLsMQ73tCxyYYYBfj2p/p2wI6jMaRPcStWi4W8qkyEIH8+iTTchWHZERBtman/iutP
         q/cw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Hz+7q5CtcKuM9a5ONWftmXYgnOk2B/HAewlafim4tObeOZReHcB9LcvxNfW7hrTu9aAT3zyh51xkIoBg2w==@vger.kernel.org
X-Gm-Message-State: AFuF++lHMMKKk7jL73NQDKNumJ+vwuhCpOc54llHX8Fie4xqFikq2+i7
	MFHIuS8TIN8cswPe7mOEWWOKU95bSP3b/KmRsRrIHnTZl7ZnjdMOROgKUHOhC/5x4K4gtfMtumz
	Lmk98sfD9DexrqI6Z7HC0byIxXCCCaYPL3yLJJ8uOTs0vWm4gB4K/NHu/oLC3InEwD1a2
X-Gm-Gg: AR+sD11dw/J/9eJlaurQJGA2KjjuIoPjOMQ4Gvq1nFw5cMLGwNZ+g9+O8ocwRgIF/a5
	mDJaucd8S2z9mBM9T6vjkTLizH6ZWD/EZt6HsCh4kreu66Ems34zjwTEmukVx01NkqBFtvKfc2j
	O06cPnQzqaxKUHQcf+NtXUWQBZ5kAW/cJuYCqcys5187Kn6WTWzTqLn9h6GN+GhUpYdx7BmIRMO
	l5MEdoPzk8zY5AZqoVd1NsZsPTTYR46D5b3/gSoc9QcgijxCM6SBc6inRNy6s/+ASiWCiA8snfi
	Ha4BNRBvDoGzyGtjsgoxGjnRs1OSr/GmX+BR7PFLsB7ET3jdrcbG+OvnZRai7M4JwknIZ5EmbCG
	tCqFn+lVuJ/sOMh8ATXvKnqqPJ1OUaQc=
X-Received: by 2002:a17:903:b07:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d64ada8eb8mr488355135ad.2.1787563033950;
        Mon, 24 Aug 2026 02:17:13 -0700 (PDT)
X-Received: by 2002:a17:903:b07:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d64ada8eb8mr488354125ad.2.1787563033470;
        Mon, 24 Aug 2026 02:17:13 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d67679e55bsm15110925ad.30.2026.08.24.02.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:17:13 -0700 (PDT)
Message-ID: <46db44b5-ae8e-491f-a381-0494fd4916f9@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 14:47:03 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: lemans: Add PSCRR NVMEM recorder
 node
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
 <20260819-pscrr-provider-v2-4-9072383e0f4d@oss.qualcomm.com>
 <yh4d3236iq4kjp5gumj6sj6b2dbiwjbmyywiayzbm4ul2mqjr2@hu3ddfqxfftr>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <yh4d3236iq4kjp5gumj6sj6b2dbiwjbmyywiayzbm4ul2mqjr2@hu3ddfqxfftr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tY_ccrDkbG4EZ7tlo0XBNEriRqIFY3WO
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8c0c1a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=A7GeVftTVcCg-GgeXEgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MSBTYWx0ZWRfXzwveFtZKDi5z
 gbaBzfe36FwRDowjlolUyHcR6gzI6hVmCSi2KQzc2ZDuDuIllyGwg+VgTOUkgVEqRm8zMw0pl5Q
 T7x2I0RnZN5hUeVJI1ANPbZ1OfUkO5mBUqKMM6sPj50prfzSWBkt8R4vAiQ1Y3ixBgy0FqlmiSp
 x5QguTrzpAJicGF4i2OSNsZlqh9zeJIYflidZ1O7WckS7QM0Zb4tgtXrypt0eBmwe5D3B7I2dK8
 Ef/8iVN3b1hezWTklxXw8sc11bsYDU46pzuzWwNMMLT1qpnu0Ftak58FXSOrbRP5W0WtwGfsUyD
 myewi//djRlvwTzWT9lKvBNUenAi4D3YdKVKavGd6IXT/OlcNQeDvtznh79KXreRDCkpqPbde4/
 EexOZSiHmoEAYOQoNqPDSudqzdmejYjXwkfoEb5OUb9NXdbGLxAgXt7l333shpQ6dycjJJDBSWQ
 l55vRQG6m9Pz9c6dTwg==
X-Proofpoint-GUID: tY_ccrDkbG4EZ7tlo0XBNEriRqIFY3WO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MSBTYWx0ZWRfXzZVHHWXFNNzg
 ugKPrSR0cULWduf/gyXZfhqlvBcynAH5A7BM5jMfUbOxxMEfBYk55NN12rMk1eDKsEkZmP6luns
 qgJeqF3dXwM9M5XKxs+8gsWiKaFrc0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240081

Hi Abel Vesa,

On 20-Aug-26 12:25 AM, Abel Vesa wrote:
> On 26-08-19 22:50:46, Faruque Ansari wrote:
>> Add a one-byte NVMEM cell node  in the SDAM to persist the power
> 
> Super nit: If you respin, drop the extra space between node and in.

Thanks for the review.
I'll fix this in V3.

Thanks
Faruque Ansari>
>> state change reason across resets, and wire it to a pscrr-nvmem
>> recorder consumer node so the reason is recorded before
>> shutdown/reboot and read back on the next boot.
>>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

