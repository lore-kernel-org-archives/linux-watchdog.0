Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7223AF676
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297757; cv=none; b=qFbo5WtwBLyP4IhFzjmb8VmsVQMkL2Nqv/FNH/ajf75LRg19kleO40jSIO8cWfLvL/sYefoStf4COaFCD+dxc6+/w/sPN3OId67HGrITV1f01YQRUgGs7XL2h3+QhXj5W0QAU6R3A67XyylA+Kf9kcbkDCVLK8aTBkcGuZySJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297757; c=relaxed/simple;
	bh=7w0MFFt84NmGn5F/FgWQ8MrDCIUeFBBGwRpERkkx5xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0pJSWwNRJ9SOntSu06EUL1LQ7c1UZdOnUMROxwD11fX8dDbVkFRYY5KsYXjaMO9aYgistM5h3ORBCUXeckiB3fc79fuZRxY1aVVMieY1Uap/kmKg/dmGMKGvbeoBwmX/gzUeyjtM15qeH6NFDp0lvL7cBO7FlXUbNwPQz4wR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWX6wohs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWX6wohs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1300597a91.2
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786297754; x=1786902554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RIKS9VjKOlpGWAuKOmHa0uAoIuM+Lm6GbejliVNCX/c=;
        b=BWX6wohs6c1VGRvwnnJWGldaxT9y4vRw6/Ay+PnEsGdQvHy7p64BAAeelp1SMJpShK
         IQdAKsmkdzV5S3OZ9yxVr2BmKO77u/KJuavBfE62za8zLKF3dIGc0k0E0SSRhlLXpPcW
         VByIQyklM2TmN6ubwDNwZiY/vnOTDFy8fqVq8XwPBbUZXxW9DJMfEiPBKpymCYmPDiVx
         haLKU5B/1+CU7bzfO8DrsgwAP9jskwD8OeELmtuJuQjGqSWntjw2D7XikLAF4kPf0psN
         vV4SXZ5DmjiXz5v9IfoxE4TSQYVwN6GGl5nMM6W6gfHI3RyVn9a2Q4cIO8iXkLKb+oJr
         lFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786297754; x=1786902554;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RIKS9VjKOlpGWAuKOmHa0uAoIuM+Lm6GbejliVNCX/c=;
        b=o+NVcdKH9YQ+yNqhKp//0QdVbZYaMkwk8FPojsmwLG5wUvsPWXRUvtvcG7aVr0ZII1
         VERG1ESceq7GwgKrpig73MiK/bfz/DofUl0/WIiaAoHuGkNaE/6X8rTZp8QjYkYRyEfP
         n5i5WhgQ9jmVLYJUsKln/fVnMay7jR89QoQBd2Ym9CY49N7SBNsYO+gqj22utHn+iNGp
         2eJwVr/urW6+bqz+4FeCQbqdA5aZYEIWn8OAUpcF05KtSwgh8k0QwCEeedpQzccpoukA
         UfToNNPsin0hlEBdygod/Aj91BEVX6SW4HqGMNTt8flYVLctF8Xjd6W4gjARrzQxK0Pd
         pFSg==
X-Forwarded-Encrypted: i=1; AHgh+RogkatWUE8LQP4Eadlon4HitghVS32gUGbaXk9YRCNxaavbaiuRoYwau0pUtcpeNACRGxZJqL+0kR4BZn3AKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9AzkJ/crGXKd6FS0dktOjmtFLwA+5604g48qK5WkePZXup8x
	iW8+JpbiCzUvSmqs3cCJBfydGajqAHyjhvFp9VaKrSXX8eYs2fixS0g3
X-Gm-Gg: AR+sD104plAP00a4I3P6P2xpp7EZTFCLekKi2AGDMq52tR2VcbO+Og5JoFOfCtTRB1H
	/0HOH0zVW75JuMgH9PCvVOBXOI7OlDEy5kESgn19hCvPfkVTIXZ4nBLtKMW+GaOvHZazvxBIGcQ
	zv3FfveORfpGydDxEaVlUH4sZHuE10nbQctvCPyrRxoTp5HJVoVXSObS6vtT2vb85+pn2kmtUxZ
	4jd8YpCQvnAvvgMVp9Mr5EFMwm8DU0s6L1Y2pm5OX5cVv6ZT5a2dEsXJYH5+WlmE+Pf6zr81C8l
	6F8r+GylKmBuPolf1ey6oivds9KNxz38l3lSOSf18Mod5zvE6UwIm9asNrMs2F3TG3tuH4ofVS3
	VINezYI8omAJqbQb8ByH/MJixuT5JLGjFvYokBZHFGrmMhPd/oUoy2y8/8Hb1d/ak9XK/nuy8ph
	L5SIE6v7+qneZPztzjmHkL+4qFYims9XJddt/uP3fxzWorJ26mLpKupf+A3V5ujJJjOQPv8rJch
	OSudExiIsU3s6QhWrNZmr+pljInJ/kd4cdjZdzJQEadZ/fi
X-Received: by 2002:a17:90b:2585:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-39282579c06mr14693252a91.21.1786297753881;
        Sun, 09 Aug 2026 10:49:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b136c67bsm4534781a91.0.2026.08.09.10.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 10:49:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e4dfe8b-af67-4dcf-92fc-cd564d7c3744@roeck-us.net>
Date: Sun, 9 Aug 2026 10:49:11 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset
 controller
To: Akari Tsuyukusa <akkun11.open@gmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-4-l.scorcia@gmail.com> <aniv5B4jz07mI70D@buffalo-ssd>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aniv5B4jz07mI70D@buffalo-ssd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 10:04, Akari Tsuyukusa wrote:
> On Sun, Aug 09, 2026 at 06:03:27PM +0200, Luca Leonardo Scorcia wrote:
>> Enable the toprgu reset controller feature for the mt6589 SoC. This
>> allows generating reset signals for the 12 subsystems managed by its
>> top reset generation unit.
>>
>> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
>> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
>> ---
>>   arch/arm/boot/dts/mediatek/mt6589.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> I provided "Acked-by", not "Signed-off-by"...
> https://lore.kernel.org/linux-mediatek/amEBgRmQktZ44jc1@buffalo-ssd/
> 
> PS: I am also fine with this patch carrying my Signed-off-by.
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> 

That is completely inappropriate and unacceptable. You are not in the
Sign-off chain.

Guenter

