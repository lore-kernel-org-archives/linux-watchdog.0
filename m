Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC643F58E7
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371876; cv=none; b=mrUuIZxDkLQicpNsyErKpc22AxuQxOQycrCBFEHCAzGMMQPk5d670A1rxUrf7l/VjPgwzPVC0bQq9syJV1JABvZwJbSDc92KNhJ7Mfhp2Z99Uyi++EKbP/jz9s2w5r1c117recf7LKIV0iR9QjAVKoa3dpVO6dIxcTYuVxsvdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371876; c=relaxed/simple;
	bh=2rVIpemWFwaPQKiWr4TkwbUpEQU4nz0aKH6/AyJYUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLAg1bIGDYM+qPyTci5eGxEYhEwuP+Y6P55K6KBWFD3ldflZ6Oa/SYjcie3DCUgqxYjKzP9fqTJ8upJZI8Cvcxx/TnLOA/Cx6Afd707o/nKEHZCqs7jm8s+CojogcK5ruaolQNUhtKDWRqJNI7nO2E93GCyCLaLixoqsbeVU2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDM5DY0t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDM5DY0t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d032846c95so24643245ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786371875; x=1786976675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ax2GIMqI2oJHn6HgwhTWHhHEkIAyr6Rp1OTrqHHWbE=;
        b=MDM5DY0tl54MM/0Fxiv08gsns8egstqYlh1NZwxOad8GssgrmK01fc/WSWYeoecbN3
         W/q+0kBhSDfekgrP5FsQgPmqsrFA20YnXq60I+6D9LFwzpBzwHI7HsVECBs6u9zan/At
         G4wv+x2qScSNhNukN7Y5KLGXKlZPOF/EfGt2QQT0MJtMxKj2YX0r7vHTb3xzeyaRZjkD
         jSf7U2g5E/PLxhgHU5lyKcBzJuAXBoUUjnfrwGEhmoQDYfBBkwyisIPaQxYAjA8kflQK
         idPL23vxBOeSbRevowup5zedm1CuyhSWTpdoB+v4ZFHD/do/MokP2MFbQEvOzIUB4lpY
         pDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371875; x=1786976675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ax2GIMqI2oJHn6HgwhTWHhHEkIAyr6Rp1OTrqHHWbE=;
        b=p8moHathImNXH9oattRysFzje9HnG7XyszD9tcdil0eeEGtpVrNJOtsnoUKg5M5IZb
         idIEDJXLVRyrtroNsR3nhEUtilHcVuUvvrvvFleuCbHyvgDQTrrFf4GOFVJLM3OmxLyP
         23gb/c3Osda4V2E37IpomYDiEwtgiyWiodfBm2oOmbLUYLNlIfdPptk2By72rYj6eoFK
         543Sa0gSPjbGZ59nyOPEpP6L5vGuj8yIVGwdZTGXvoIw3QGlwdQMab/+AoekpnyEQrMs
         SPY7vu2PX7jRAjrXd29WOjH9UKBNsSS8x3TK0Fxha01bRoRPNzrbcZIwdUgR/G1qcjaa
         S1tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQae6ahOoPLx3Ot9xKGg2jpWN12uxo8cu6AUiefxBq/ka6ZPkMnGq58WQkUyLCLMx9QVtnJPP8SwUUavsXPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcR7YQzNVqkq6p+OdnNKki+0MESlvzOQE5YR0xXy1cKG6PbSj/
	G4h5QXA6MgxaZw5DQXVfpAQojrBL/w+4cQIhgn0qJ4u+vyajpVsaeCSaodGMhw==
X-Gm-Gg: AR+sD13oNvNPrJdlwRYohkBcqioO4w6nQAP1tZJPW72UQeJD2UEusq1I00qozQHAA9a
	YHn45dY8XwaT8AkbKOKd2q0bpA69qKgXtXpQzxdY7JbevgDCz8tHcLyGUpYLgT8je0Yg0ZC/8fh
	CwQk4ukQDJcurEbqAg4k3KB7/Ppk2Bsecm99seQhND06G7ykWwUDU7OufxwuJkgfIzPSMcg6Upl
	VjfAc0gYqoclix6j5mzaqTT0tuCRfTHNVn4swsqFUcpGqdW5bPj7yU6ufxWXiTxIvfEBhrUB8l3
	H8WU8T5MWce0fi52cyb+h0lTT1udINDqZhUq5VNG+ghvwK+NXjICF3eN8zjfoN0N3VSWXzbFGlK
	hMs7TmrOkPCXAwuPSUYMY2hivt3UKXzWYGrdGto9JP9RjovHvgCq4FZ1D9vsmZ+j7RRd4OT33zx
	Hy7Az9iXD8y2erO15HnbbLnOTg6rblxVdewIhooO7+4dmHYboTGhlaw+VLyW3paY4bkkWQCV/io
	A==
X-Received: by 2002:a05:6a21:7308:b0:3c3:a1e6:a626 with SMTP id adf61e73a8af0-3cc1a3f1658mr2809036637.32.1786371874643;
        Mon, 10 Aug 2026 07:24:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3d1sm46551457eec.2.2026.08.10.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:24:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 07:24:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
Message-ID: <01283c69-d5ca-42b0-a75d-6ebb07fee46a@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
 <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
 <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
 <CAABR9nFcitFyS_xZUkreHWp822iVsoEg6ONFwU9JwPaBqm2MTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nFcitFyS_xZUkreHWp822iVsoEg6ONFwU9JwPaBqm2MTQ@mail.gmail.com>

On Mon, Aug 10, 2026 at 04:45:07PM +0700, Bui Duc Phuc wrote:
> Hi Guenter,
> 
> 
> Thank you for your feedback.
> 
> > >>> +                     return irq;
> > >>>                if (irq > 0) {
> > >>
> > >> This if () is no longer needed.
> > >>
> > >
> > > If we remove the if (irq > 0) check, irq can be -ENXIO and would be
> > > passed to devm_request_irq().
> > > I see that the irq argument of devm_request_irq() is an unsigned int.
> > > Would it be safe to pass -ENXIO to it in this case?
> > >
> > No, sorry, I was wrong.
> >
> 
> So this means there are no issues with this patch.
> Patches 2 and 3 have already been applied by you.
> I will temporarily resend only patch 1:
> " watchdog: qcom: Propagate errors from optional IRQ lookup "
> 
Correct. Note that gmail may swallow this reply, claiming that it is spam.

Guenter
