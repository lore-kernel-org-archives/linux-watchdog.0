Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251C1C7EE25
	for <linux-watchdog@archiver.kernel.org>; Fri,  9 Jun 2023 12:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjFIMSJ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 9 Jun 2023 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFIMSI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Jun 2023 08:18:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E87172E
        for <linux-watchdog@vger.kernel.org>; Fri,  9 Jun 2023 05:18:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9745baf7c13so257829866b.1
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Jun 2023 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686313084; x=1688905084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRu/MVTufeKETQpJiuC5cRhJZg/KSEOpieRmGz/Iot0=;
        b=AT+JS54/YcoxeD2FdFUR1c83U5gCnppF6Wqq4Fqf03Ocf50lfnu9Iz1J3fbY3NvViC
         yJ8iYceB8QwKYJF+6i21C0Iglu2XxMtfPcV1o3T+u22tXGSjBkrRM0Pyg/r8FCrPJ2jF
         qdvGX2fGMv9rc5wwDLf5bCytFUlkVnwkGamRYISctSFeDvN+nhHC9pItSmJ47G4nB6AJ
         QhI0ErpMNzwKEC7ZQCXJtiX0R/vOBV+hRyRetMGrQJMKQZjw10oV5n7JX4dgptdZC7so
         SGZUMZvBWy/H4ILCM2M32TjsoDjwLZmJSHOHLMTKYneNJMYuaOj3vbePe1Jc2+cbSYmP
         lp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686313084; x=1688905084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRu/MVTufeKETQpJiuC5cRhJZg/KSEOpieRmGz/Iot0=;
        b=LHoef+FfSVU6SaeJAyWyhT2Mmqd9a3rUX8UwdTQHhsFdnPXJT3LY0MceN1HuMPzftt
         Alw20tnrdWjF0XYDZfcNKCWTmd/Ij70t/q+tt+gtPKJJQEYvjQ7x28mpYlSrrgyNNKOq
         9j3GkP7KDkK9R0j9MDhfog9KFF9l9S+f7PHJ90UUthMOQN9/2tMEE/gYbs4qQeZ2Hbd3
         CLYIGnF2aj1N3dflgQ6kXD2fEtlCC3kRqNg9RzcHEakx1Tjbv/FWOmAbTEAuy/7MpDfR
         DmZQHhGsWXtApFY3WFEpNdWq7uqxwtREW5RQZ0EtFzvV4ujtHKxu//0f/wPTG8VapCsc
         WVyA==
X-Gm-Message-State: AC+VfDx7yqqIIl5yCDlEwBKeG4zX5nO2mY/2/YtMqHuOOYQO0vGJrxwF
        LqnEnsi1NHzSNwrG3eKb1SgGyA==
X-Google-Smtp-Source: ACHHUZ417yfakjAMO9xbKZdpU50YulZOcwBUk+TaMyty/uupw4mVV6wMBq8n6/EkUfjiyLbm9NjQTw==
X-Received: by 2002:a17:906:fd87:b0:973:e79c:3da8 with SMTP id xa7-20020a170906fd8700b00973e79c3da8mr1478316ejb.17.1686313084557;
        Fri, 09 Jun 2023 05:18:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906129300b0097381fe7aaasm1215248ejb.180.2023.06.09.05.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:18:04 -0700 (PDT)
Message-ID: <5fc609e0-a70f-03e6-6ac2-db96a2ff7747@linaro.org>
Date:   Fri, 9 Jun 2023 14:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-2-claudiu.beznea@microchip.com>
 <46eced08-5bf6-3e4b-7a91-ff4d16c7dab9@linaro.org>
 <e816a8c2-e4fb-a608-f8e0-232135243c8a@microchip.com>
 <9e4a0756-8b42-81a7-5b5c-60c0ebea0d7f@linaro.org>
 <e8fd0340-da21-0cf7-7ec3-a3f278716c15@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e8fd0340-da21-0cf7-7ec3-a3f278716c15@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 09/06/2023 14:09, Claudiu.Beznea@microchip.com wrote:
>>>>
>>>> interrupts? They are still required, so why no description here?
>>>
>>> It was here in the previous versions but Conor suggested to remove it as it
>>> was nothing specific about this description. For the if-then branch I kept
>>> it to specify that the interrupt is share with other devices. In this
>>> branch the interrupt is only for the timer itself. With this, would you
>>> still prefer to add it back?
>>
>> I just don't understand why interrupts are in one arm of the if: and not
>> in the other.
>>
> 
> As previously mentioned, Conor suggested to have it like this.
> 

ok

Best regards,
Krzysztof

