Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E373EDAB3
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133350; cv=none; b=lNb5hqTVhooCeKdPC++MuG9wI5o+HPg9q666ovKWDYajRSM20ZvqQ6CH30cFh+kXTJhFxW54/lix9d1qG7Rs1jU35LZ7eZZDPBaQnd7F4eCSclQ8zVRUsIc3ccJVbBlPCyVFCjgRDTkXWiPF46Rfw08DfZ6eJT//8tUS/IVRHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133350; c=relaxed/simple;
	bh=7IrB0okd03Aqpih7Ns5d5dds/+Un1am8C/UF9ELzHjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/Pkfv7Z/nQg0VeGyDd+nyc9s07yhoDbk0Wc5fyChKMtbDVyKqQZDoAkenThXi6fygr5vqbsDq3TBmPzgYOWTIWNqgHAhGZBpfdSvDhGFssc2Vq/avyhnn0mW5y4H+QY7Tk9oJtqCP4FufeSc7+MdYYzFgua99pypylWT1+79O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCY8RiUX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCY8RiUX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848593533cbso3103618b3a.3
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133346; x=1784738146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKMpslmS1nZLwbcYPHb8iOZLrmPISU+0dOPEfAdriDw=;
        b=JCY8RiUXpBXqEOBcCz4WafKkyHB8ySjhgeWB8GNXpoxdYAFfl2tk8WWSznNL5s2BNA
         1JdEj5JeRiy7hx6ccsoHwDQRLe4VNpdsjJ0Oqibb/lGu5lxhSCYTvfMZHkzDPGRsgeS7
         Dpfkd8XKHPAGyGd32nvlZ2hOu7P7oJt62VrioZfemi5jqEDQc1OgMwslRo4Es8b8YJ/M
         KyRDmEetrbnIp4UAoQmeR2+zRuPwe8j1gAYhD1PB7XyXJ/SiPIOBJpqo22WcHxe1Wh70
         7Ua9XjwM5KVybYBV3j6irPrF+ud6FUG/PNLXbq5PKdagSe8/hZzAkB8B6ak8w/9RCltM
         Rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133346; x=1784738146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKMpslmS1nZLwbcYPHb8iOZLrmPISU+0dOPEfAdriDw=;
        b=nIewCBW9j6g2RlgGgR7nTDmQJ8hFKvcALB+MXvi1JtYTxP6rG6/YLScaf9La0mNfrZ
         gz+xfJwNcfXfT5a3fXG+vKQcT7d4cTZZVP4P1ZiWQfQYmbzq+FA01FiUgKSMhLScAERA
         WShFfyIT84mpYLuWj9moDGAU3Zsq+2wYw1nUDNxkdFkl/fPHTdjdOUlmdtXAIZdZTiqM
         AdZ66yvsZ3SPOcIbCUMkFjmAYZ9hFu7ewTPbeH2/0kX+I/5Mhx+SMnGPq4u1ILluGmLN
         fM9GI6pIXEL2OPUkh7Ao0/JsZ2gkFhZCE8RPK1uy7lUfhRRk5cjxjpffm++HEeBMKlg4
         PyfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBM8tpKUPymI3H8MnipSDoPpsF+xIUZa+oEi5FLZ+MfW2bc1/LPWjgZESGAdvZ7zIyqWRr4QhtuqV7O9GHvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbskXjCseXzhUrxvy7HTDZPRej/3dOXlc8/j8vHbthQ/MxIdm
	gxmSgzeKa0lm8dSFVYf4TWblX9EtnqTlSzevCpL8WEeme19WfQugGPY5
X-Gm-Gg: AfdE7cnBbi1Q5oj+qImbQr0BdBc3uglxndvugqz3Os76q6Ow7wih8Z5Zu5o8Uz/d1J/
	l0FUPKUMxfSApKqi9hjHwDdPRWHwVBstLFz5owvdsrHu1Zv6/H3Wku0heNeqBRqiG+mhqYDxDuT
	7onRxLP+j9gQdwl9zi6321FIw9nFC6cOZYjwU+SOpOAZig3MUivDVheXtuqs/llwmav/Wse991g
	YzePbozZEVv6E+0bh1HiYj/wR+BqbXwwu44tR1LHgyeABZ4/0TWsg0EUi7KffUNAuL3VpLF7/mb
	B8vDV9xwYq7pXSFzsEKc6G1ztMub/LECfWHGfMtFYukNtiAMATVdnRs1hUwnumLyUz+lBkEQjDv
	RKllCLUUJMMCly19LbZzWbf0FZur/8JhppYSZ9Itp07BOtoVnKNVZYIh9Fkg5mcs8o8FSzhlUFA
	FXL0qysokg78iGSWlnmT0RvM7pvA==
X-Received: by 2002:a05:6a00:2d8b:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84a672425fdmr2861024b3a.16.1784133346501;
        Wed, 15 Jul 2026 09:35:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238b21sm3470359b3a.7.2026.07.15.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:35:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 15 Jul 2026 09:35:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Message-ID: <990ec316-5050-4e7b-93f4-b5a2a85ef447@roeck-us.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>

Hi,

On Wed, Jul 15, 2026 at 11:11:53AM +0200, Janne Grunau wrote:
> The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
> with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
> "apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch didn't trigger any conflicts against watchdog-next,
so I applied it directly.

Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 845b5e8b5abc..bef8255022fa 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -18,6 +18,8 @@ properties:
>        - items:
>            - enum:
>                - apple,t6020-wdt
> +              - apple,t6030-wdt
> +              - apple,t6031-wdt
>                - apple,t8122-wdt
>            - const: apple,t8103-wdt
>        - items:
