Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636063F7A9A
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900596; cv=none; b=COwHDmrY4+yO0iLVTDZykxJnSRDZBg8QN+0G35BaN6NO7qjktflXbU+S0okq6750CZ1lOiO//BhKOjc5nxUVwKpIyaYetYw3bjMVbxUKb7wIgMVabyi4M6MSY4lR0ND7sGBZDguzJ+RDOyzWbNn4VEpzwMuD2dKTHXsMXaUkK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900596; c=relaxed/simple;
	bh=p0X5uA3DQy8yO93GvvIIoj0wSifsuyv4UXPNTkOA8Ds=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r/DMPIgobiengV5ogOKjUWs1SeZLxJupCeNc3g2na/gl8/rJYM3GjWHs/pzLvyzhoW50twvpb0m6YAgldWm+Hxd1QLIkuQ0byJKcds26KtCSo9NC8KZF5DqtLeEOAwernGR09x48wDCzH6T0jVmpZy+ioCShsteQTGwfYpet0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ky7xlKfp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ky7xlKfp"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso34526315e9.3
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791900593; x=1792505393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gz7YvLuD+BSS9eEd2mSMPhx0X6MoL8V0Pfz5H669ykM=;
        b=ky7xlKfpdY+ZAIByV2sKs3Eh+O9fb/ZDvwe62bs53STFiwNoXyNP3OYv5cIhSW4/9Q
         Njk9aELTpKugAA6sp5zrQSHQMBb8+3wrl4+xBC3ED2NqAoyxsKh4DFzDp+FlWSwRhtAZ
         gJJI4h6kpP1wXIM8AdEc8Eiul9CbQbbj4Mhsq+ywjcy62JTs0h2jSG5fGRo+gHKnMqAN
         5Eqgp5eAMmvkpjd7FGS4hYEv11ebmllc4yoj8xMxc1ZsPQMFzzvm2UeshZtGVdDV1tlI
         BvqVEBd8usjXco3rbWoNWLFb2XsT9fWtz/fPXkxwxeltsGUqpQKDJhOdIV5nu24eLX7U
         GQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900593; x=1792505393;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gz7YvLuD+BSS9eEd2mSMPhx0X6MoL8V0Pfz5H669ykM=;
        b=NsvFVZMR+QYPQ5gI4C0tVaJ1EG9umUL/y1OFy6zpDy5dlnT8DKoATuVHxQ+NPBcQfU
         tJP5FmIVPf5/uMYNAT9+VEDxuaJLWYnzD6KkTOMgqVUce4tJOemXSSXewHMo3gs6RZvN
         xmiIlPk6ErCoS5dDPPiKsLZBLQ0h+isn+MMLqLNvFnBjZYSrNLpyjwmJ+rRTJlFxbNzQ
         24xLR26ySE3afSKtWcyMr2/1M3GmtTpG39qbY9BolAiiak+gSjT9cJ6cZYzYhVueUQWS
         yKmLwOiLy852KTQTIQBiPVvCUvREyF0GvxxEsHnW64uZWA/XIw9euqH4j1UKHZD+1YR4
         1DGg==
X-Forwarded-Encrypted: i=1; AKwUvBxG1PDTb63rrbO2L/hRbLOwFdesAbsuQ9TH58XPFljKxPsdQGkzpXEWO5ior06BL2tlEpL3vK9zBqBZsnJGLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6mfY1xEixdpmAmDkwGwFSkIDGJWvJHv5sP4PoDpwbge9E8JTa
	hAvGvMVvx0HWrPtCe1hhv5uLsZm05sxH++ewYRHKDbgXynDg+IBr3DceoFcXfTnYOAw=
X-Gm-Gg: AYBFou3e96PyA7Ok89ruCAIkpk7GdcBPc18/iVEXwKC6PE1hmB+tQ6K39OtntcAG6dm
	v+fsQ/nl//qYdUoUntwMEgq8vmwbtqzAmcpFPgM7j6Ke+MvtThyqRRRzOMLXadm76lseoFgKMzd
	SbTXTnpqT8E4iXHF8FkTvCVNfxqnCNn91coRkpJxX5Q+gmSfhGnuJmBk+F/qCdROAb+eOfUFeZM
	xb8GqgYEFMy6slnyvLInOzr7jE9UCYx5RI6HK8rTzF4NHXsq6/2ZSebGKYDJTZZy9EsrFBDglMZ
	7Aay+Ot2fRJ3hm5U3Gm1SVnjlFIzaQceS6otHYI2IJqfBfYpDdV5sa0LwhogcNmeQLDEDLcV7rE
	NPR3RPKTda+eG0YnyPeR9Oi8aIkFzNkLmhndmbGC4MJVx4waQDQ43vIKWpTjgQgPVB20b6vxrTJ
	klevhALTUWS9HEfNOnrRlp3heNysRgDlLjwjKUTZUcdA5Wkl7rm0AnHDgVIyRxzn3zp3Z0ko7Uu
	3V8tjZZdd0Shz4WBqniqx6mxIbidmcwtHecIQxbT4NGsi9BX8C2MQ==
X-Received: by 2002:a05:600c:46cc:b0:4a1:688d:a41c with SMTP id 5b1f17b1804b1-4a18e4c06a8mr234176075e9.25.1791900592528;
        Tue, 13 Oct 2026 07:09:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb? ([2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1972eaed8sm253144205e9.1.2026.10.13.07.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:09:52 -0700 (PDT)
Message-ID: <8b331c92-ce18-4886-ba87-77b6156cc9a1@linaro.org>
Date: Tue, 13 Oct 2026 16:09:51 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8650: Add watchdog node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
 <20261002-topic-sm8650-deckard-watchdog-v1-2-7d7f7d71d88a@linaro.org>
 <f6febe84-c7c2-4aa8-bb02-5b56c63abc6c@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <f6febe84-c7c2-4aa8-bb02-5b56c63abc6c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 11:21, Konrad Dybcio wrote:
> On 10/2/26 11:45 AM, Neil Armstrong wrote:
>> Add a node for the watchdog on the SM8650 SoC, the node
>> is marked as reserved since on most platforms the Watchdog
>> is owned by the Gunyah Hypervisor.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> Do you have a HDK or something with gunyah at hand? A couple months
> ago qcom_scm_gunyah_wdt_init() was introduced to handle this -
> could you enable the node and give it a shot if you have one?

Why enabling the node ? the qcom_scm_gunyah_wdt_init() will bail out
if the node is enabled. Here we only want the node to be enabled when
we are in EL1 without Gunyah.

Neil

> 
> Konrad
> 
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> index 86fbb0fd6472..f33ed7909a8e 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -7311,6 +7311,14 @@ gic_its: msi-controller@17140000 {
>>   			};
>>   		};
>>   
>> +		watchdog: watchdog@17411000 {
>> +			compatible = "qcom,apss-wdt-sm8650", "qcom,kpss-wdt";
>> +			reg = <0 0x17411000 0 0x1000>;
>> +			clocks = <&sleep_clk>;
>> +			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING 0>;
>> +			status = "reserved"; /* Owned by hypervisor */
>> +		};
>> +
>>   		timer@17420000 {
>>   			compatible = "arm,armv7-timer-mem";
>>   			reg = <0 0x17420000 0 0x1000>;
>>

