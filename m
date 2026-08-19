Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1584078C7
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165723; cv=none; b=FhC+0SWX975nKgqNrSuna4VdWkparG1eNlXyQgqYvBEMkstnB1aMRQZd5ugACatVNKzaULyEN7O44rdNZxjpnpmxZUVYPAgIFRd2n9vPCJG24365RrZEQ/iZqZWfzAGCX69QwSV8X0iI93MOpQY7uAgqQOjb9jpY+9mco7dH/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165723; c=relaxed/simple;
	bh=JF89pNt+wExytSZXMxkXOZVOBdOMKxbaW21qgJgND1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwQdX/r/FyeYbJJphu29BC96y9HFlW9HX69hJktlHo6BSaF+xRDFbjzFDKxKDkrNATqFowjxyWrU9lsYcvBSbQKExEqPffKvrb4Huq6A3rrz4Mt0RPeZtOcYtHfi2bmeP8YN4MWvNCSSBkvYM2jGGJi/m62W7J2whQhAZLX4Ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTcH2Udt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CMcLvAqx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTcH2Udt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CMcLvAqx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JHqJOK577899
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 18:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p8I/883i+Fw2SDGjY7bBs2bi
	TmL4wubFWVmWaBFZXfM=; b=dTcH2UdtjpVkcr2FlTbDXTwnRlPrQIr9ZxeY/xbD
	UtHWIUm7DQ6TTVkRL//18D6IR45UwtJuCs7EQkWtuNyLD5F9Ojvl49CiExVYHl+7
	zYCJU1gzLJyxUmUFQrD0tn+DyJwTBba4I5Rr5BXDdlGsuiRYmtio7LF0/i43cPV2
	+DguTxuN6bTCA7N+5eBIQZvXrNRbTBctIXu0FVhd+2KFqnO+VjrCL4YjWA8lzMSs
	2+MfeHRa2asD/POIXXvxO1zelaB8+DSFIg4O4ChtYGA3hnvu3Eo48kJRC8An8WXr
	GuGFZQ+kP6DG7QtpNQWvl2jL2dKoIVAyI6jy9iNHDMWcBA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esc15qq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 18:55:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e38fbc5so183063985a.2
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787165719; x=1787770519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p8I/883i+Fw2SDGjY7bBs2biTmL4wubFWVmWaBFZXfM=;
        b=CMcLvAqxSxK9WVKCSRpgZEuo54YqxHlxMw0dCuwdV5XftNrxS+1RIOnwRT3iZIThJY
         Xwtcla8qhFa7ozYolrPhvtb25jHwgT9c3MbbMrfUR+Pka+orliOSbxJdO3zP2GLokTBa
         HTgqxKkpu2sQnpEyQrmtSEKbds0XSq8MyELQAq50XYA9UlCbyL6GtSOEN8FxVgKfjyMj
         cjyIt5iWa+b8D1LvSQ7TOx21awz8AdbCV35UBKG4Y2tXlLXGdCQgrUWd5J9r0UdzjfgL
         XxYG/27NWpDZLKL49KND8Tz7mjJTMUESjsluJCVRuTI8sv2vpMBpktRNLmUcWCtp0QCN
         AUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787165719; x=1787770519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8I/883i+Fw2SDGjY7bBs2biTmL4wubFWVmWaBFZXfM=;
        b=ndYYOlRehQn9o1NFvEIbwDLrb6Jc6eGq2QVArzHEnyr7jmwGQJSbcKOxnuW3yJ3m11
         4osAcv/cUJ6alQiEZlZrcDaUTA+uuYPvfmGwQ/5gouJgKyIC5h5k0R7G9IinWkhcizdi
         MAG7pVuZAz+kcwLjmD7KaO4Oe2gwrZXpCNITmDdlF1dq1KeiBtRLtKzD2/zWF/OvGbYg
         g6TBFXlJpDzm5EMhyh5vJ8qg8lhzvrFv2ADn84hccEMptv10mvzFUEALMBycqG8v61xk
         rcTbK1HU2ybg9cEqHTEbR8JIUg+MWw7Sqg5KJBuDhfBhH8cNT03xpWxEIf5+uws2xE8o
         afjA==
X-Forwarded-Encrypted: i=1; AHgh+Rpq1wAvAh3WBsB1ktKry8CkfbqrUFdyP/C8xXu2Kk8KCJgLJfeiVe/rqxlpE/6OTfTFzHJucq4dcE/tPqz6Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdP3KU+NNSRGrt0TbG7R8TDZ65e6VcFbMbYQK9pq3LRRDLbwe
	xyD48+JNl9ZxQDsdtUVGOKLClSRqW/l83+Z2yGCqkddCKgLtdv35nQWcb4dYd95erdKb5xddrE4
	ryV6VWs8yz8XYkPYSrOL1tWfNgmEr7/Dfc/sVPDvTJnFfFTNzGFhb9c/VgFlwJnfDOM4O0Q==
X-Gm-Gg: AR+sD13DTT/UZD9uyjJlk9fY+/F76qiAHX0omeQZ5UYDPwQWFVZwUzbeZpDwlz4fMZg
	fj79KsLczfGEgTJruMhfDPYtsOi1Bbx8hMSaedXm7EffCpyi1QKCmNulj4OlG19qPNPRRY1kYSN
	XhWTqG8esDTHYUpmo0LwnXJl5llSwVradDLgLTJQVnPWHqsmOOGpg5dJ4qaVpu24/2yUW2GIf+p
	rsuLsnsNwYvxKuM9AyzJxjDfWNDFRKr3YWJCHdvhpQqf4bJqU9fNYAxuSSvS0wqDlwhFW/oXENX
	w8FNkLPsz1X+E2p4ux09D1Aa/l/Bn6jEkEKV7iLTjS08qf2F+cAIYSTvmtoB9jdbJz2gPifkmgK
	iA2i/XH2YAiJ+Qqk=
X-Received: by 2002:a05:620a:468f:b0:915:9e84:85d1 with SMTP id af79cd13be357-9371e2ff406mr696206485a.23.1787165718926;
        Wed, 19 Aug 2026 11:55:18 -0700 (PDT)
X-Received: by 2002:a05:620a:468f:b0:915:9e84:85d1 with SMTP id af79cd13be357-9371e2ff406mr696195185a.23.1787165718035;
        Wed, 19 Aug 2026 11:55:18 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b80a5sm7640526f8f.24.2026.08.19.11.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 11:55:17 -0700 (PDT)
Date: Wed, 19 Aug 2026 21:55:14 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: lemans: Add PSCRR NVMEM
 recorder node
Message-ID: <yh4d3236iq4kjp5gumj6sj6b2dbiwjbmyywiayzbm4ul2mqjr2@hu3ddfqxfftr>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
 <20260819-pscrr-provider-v2-4-9072383e0f4d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-pscrr-provider-v2-4-9072383e0f4d@oss.qualcomm.com>
X-Proofpoint-GUID: 48zOTLcLNcydsO71WIzwCk3M1NpYR7gw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0NiBTYWx0ZWRfXyRwx9GiY9WT3
 LM4fr/m/9pgf6KpEFfjChX5wpOvWIGJshejYjcrIPQnoKsFl/1Mdc/N6drb8Ej9jMJvvliv5pjn
 FutgSyQI8wPsWUOU+w2yEeg5RNKFbFM=
X-Proofpoint-ORIG-GUID: 48zOTLcLNcydsO71WIzwCk3M1NpYR7gw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0NiBTYWx0ZWRfX2uYvabl1D8mR
 4E6b8afa9qV3uWCNjDxvxxMR8JoG1v+eGXIUcv55O+tVXpM3pWmWEZMrSMrMb7oCueHPtrY1ibS
 BHSDxvZ2XR2SvGsYXNUjaYAcEI/gG8KUoPU/BYsqa3AaEx1v+lGsJ5fuhBLxKfCBw6Q9G23nlTO
 8EQXd1cauB9am7gvDB4krC89lTqy5ZxjDovGp+OV1xBHQcRuNqRic9bZ53YITFXf9sIeNHLgQ9L
 HRa2OqEqmlLpvp6efzs+WDhLvEljw2P3QwnlTjo263lVTboSwGefjLnGFDeyNXiEXkv/4AiJAI3
 CP67pGXYoYSmQK+WxTVYaSf+WnlpkRxZ1wAy0iBC9AEETF7TQ/o6sZ4mJ4iw56PP7jTFVXZdkDY
 hl0LRsQqlFkjo5WXzAv0Xq2fiA8rV+jBV05bqdBYCHP81blqmPu5+D2JgcoqeNDAYBnwRsf4Pi6
 tgyvaHE3dcErRbPUz1A==
X-Authority-Analysis: v=2.4 cv=b6uCJNGx c=1 sm=1 tr=0 ts=6a85fc18 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=DCxrtmPwReth02PJCqQA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190146

On 26-08-19 22:50:46, Faruque Ansari wrote:
> Add a one-byte NVMEM cell node  in the SDAM to persist the power

Super nit: If you respin, drop the extra space between node and in.

> state change reason across resets, and wire it to a pscrr-nvmem
> recorder consumer node so the reason is recorded before
> shutdown/reboot and read back on the next boot.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
