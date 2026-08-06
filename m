Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68312FF69
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051735; cv=none; b=plvQZAIOu1Kj4+/2Pliodn2cCb8kGROPBt79OCCEqmqM8p8MbzOHNMebKYNrxAyVp9UOd2xOXpWlbxc4cO8LSP7LFR5jmnKngDdVh4uKW/8leCnLYEbzrLWezrxqKIGbDEh4aSavWGktqAX3WDegSKGD/PdhuY//DcFcU8iu69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051735; c=relaxed/simple;
	bh=HPt3knmaysnTLZi6+vemh4TdFTnMSG/N6rThhqq+JO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrBqqaoRzpeQO/eF/vAadb8sTCdb1Z5AlXUo5RCP57uS7S+jELbJqgbmQf7CCaS0MzbBv9VBfkxzf8qq5U96WgEAUyUC31Xdpa39xYET1LPPONQdX+zDvcdV0/UPDXTVeZ/8wQGYTgZkalq5BfJWY8GzZgaED8eBg4kP9Ugssf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEHuY3MF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEHuY3MF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2385822a91.3
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051733; x=1786656533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+wdU8SDUgGSQi9z0LrUHaN7SuK5nD8YNmGtbuiGl9Zw=;
        b=NEHuY3MFoX1KMI/S9ai8oAmkEuQF6DSO6ZaElaIY0JHyjd8U2dYORlXkj/JTEvhVXL
         E/wmwrwVHldz99WjOD15TUu5X1M98yPJ9ViWPIHveJ3RGb48QUQmrAgC7Oo1mWmDA5XD
         1lC3HGWQbZUN8ZX54GCUOsnNsuwls09CyxajgIy736EpauGUr6M06/UVosGrURPUDp2/
         JmNN/MfISyvkBzsewDzskVourUQMJgkCdM5OxaARGvdi0FqTjTiLyakQU0MCTTiASeSG
         F7BqVLumAcObDqgemAraatoKpox1lKgXP/a0AgW+mRUhdgTZ9fiMy6ZzYIcUUP2M5yTw
         gpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051733; x=1786656533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wdU8SDUgGSQi9z0LrUHaN7SuK5nD8YNmGtbuiGl9Zw=;
        b=NKYSo4SR+1LWSSiWC4Ua8w5X+VGjKduVH6qwX7LxvVtg3tpJ5uG03dCZGSJyNgkXhU
         FmPuenAt6NC0cu5HYJbDMXHsNkCqQEiLDLL0nvqTpTzQDuUxlqJ0OoksJ8AVxqEE2S3D
         cK4vHWJSmJvsCEhF6N+Px0mAxrbiDTayKyUHx5VYAhR0IQ66yjUGtYuVWwjJ9URnrD8C
         JIrKuZQKJiob5YVYKQqBmYK2YqUscF+nTjDmkaQZ42Ig3AsNWzs1HtT4St0vXkkSbjHW
         UUU99gBV5Hp4cjfQ1M3/VSU59A0xyVKD00KaMQVak4mMcPgMeKr1IlExm4m8MCLEkX/w
         JPbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUT32cZyeKTB/LdCTPDZquSpzvpmA/Kie7TSTlr5VZc1/pCBFWBeNLUFU75KwvmGZcmajwxRItCktTL74V+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCNQ9UfAlVW5BC3nwg17Wv9zYTg8dmF4rUYohpP1uNKb+tL/t
	r98bTXhEhLJBsBInI/y5W15c4vT2NlbXZhHtALusVmb81PIKapucW4Xe
X-Gm-Gg: AR+sD13gFIOA+0fUNhueelctutfwV4nP536+ESk9cgyyVio5Uey8XuX0U9P3XMttLU7
	3bU1ecX1a2CLAoPw/XNzAKW+wnSSAfBzVI0xnw8FYOh7bdtNtupjnZpyPPFB0DFqMfd8z2HQNXR
	fxsRs1Vyx+uHLzQYXgJ81mYK7NPiN+EFeHAHJ+xG8UwcJtuqI9qjym97TwqO4Mo26FpiFmHw3hB
	KZTUsk6WMpKd25A//GCIW91b+PqSfhnRe7plAI2V8/CD+1twR6+I/Xq5RFOP4Xo4Qtr4jx9fh6F
	VS/0WczdNBaXJOSEThsvo1QWAHRCrrejWqFYSjusv5UB8s6oL7rP7YIrNofEdsQb0urbR/5D2Gn
	Hc8QbCE5c9ro5PWhoMQKFq3daP+yDijOGabDg7P+npGrmV0+Rmeyyfd4K06rXw8nM5e2fR4zxvv
	qU2XyQpqOswtvnP++rmQ3EJ18mbHbtKuHCDfuMUYWXVET45AdD5v3hE/juD0Tu2pLMEkSJ6FhNj
	HQ=
X-Received: by 2002:a17:90b:2790:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-3909d8d3ac0mr5025025a91.15.1786051733205;
        Thu, 06 Aug 2026 14:28:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dc397esm2325841a91.2.2026.08.06.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:28:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:28:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: booke_wdt: Document unused parameter of
 __booke_wdt_disable()
Message-ID: <5fa154fc-f2f5-41e8-85eb-03c221b77d4d@roeck-us.net>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
 <20260730060617.7-3-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060617.7-3-bbnpreetsingh@gmail.com>

On Thu, Jul 30, 2026 at 06:06:17AM +0000, Babanpreet Singh wrote:
> scripts/kernel-doc -none reports:
> 
>   Warning: drivers/watchdog/booke_wdt.c:158 function parameter 'data'
>   not described in '__booke_wdt_disable'
> 
> __booke_wdt_disable() is invoked through on_each_cpu(), so it takes a
> void * argument that it does not use. Its kernel-doc comment does not
> describe the parameter at all.
> 
> Document it as unused.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Applied.

Thanks,
Guenter
