Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66293E5A37
	for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778953091; cv=none; b=IJ598mVQ6zhvQmy/thHWJ9vMFjvfA/lrWBSLNQ0G73knQHZOnNH1UdzAesQHRCbLXzlIIfnuXu5/1lFmmtAmTEGUwlE+ZziPEz5a5/zWBl/C5j30MLNYu2SiGTfMh+0W4Hh/m9nrbEzXa+m3ZgOURQADQ66njp+UdRX3TgLksBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778953091; c=relaxed/simple;
	bh=vxh6M1MxK1RY0rQsG0lVBWoXaxQNGLvRF+/Frs6GZ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cStepTT0Ys/BwpPsiV2pvQtVzhN3vPIg5BLksu+4DvVThgJ40tQBN/R+5f5sFAHxqfBslFNUgF3Yb3z33JS/jkfFw+j8LZ1AoeHPCBzWm7zciFl4rE0WARZNSiE0Tom42Dxwb5JSIq+113MCPFXi8WeoWpMIU5bZ+ysui513pVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm0RQ+t6; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm0RQ+t6"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1354403c610so2580233c88.0
        for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778953089; x=1779557889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7xp+M0M+uF2jQw06QfI/Zl/A2T1ICq0XbtWBvi7M6Y=;
        b=jm0RQ+t6G9lKu/vHyvxEEXQUpuyFpMZYyk0ItHUPABbahnmblJ558coVLG1elaY+cc
         LVTGyQYpbdefDRHyrdqiBXgCxt0zJnqs1klx1c65GDvCp4JrusNZDlwbhN9G3zqj7kXU
         OZagjQX6kuS8eVFO5WmudVF/1mpd1FGwAvs7Cgghsk3sJIdRHwnh9WvbfdVEZxgTr6xK
         59f9JFpIH8v6+K5E1dOXcnS+5uZu63B/yCYJVVQAR5JieWylu58E1ayjhQxwbDiGO3zj
         AU2EuApiQV5qu2X0IHV1YrcgAM/8dm/q48kgq+BUyi9ECUg00xdlcLxSSHHyGtWG+xLs
         P31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778953089; x=1779557889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7xp+M0M+uF2jQw06QfI/Zl/A2T1ICq0XbtWBvi7M6Y=;
        b=jvkuSmVkXBvnSwNKrftWALMxMTRF22TUSTbCDIayx8xCw0HGt5aYs7yJGJ2QzBd+UF
         la8cXVWma6HqavJ/wZJJ8tWuZQFZiZXJ6sdnrNypWovISaidc7LUqoEkwEdVCorVZhUy
         tIk0ZK07XwQVwy3W7/Cbf2RAgzONCE8M/KylryREws+gQYeyCfmBBEBF89izKrFjYcGL
         Gfu4VNP/3fXdiieeCtkkoq7/RtaglJEyJNqlrFfFDr4dwJtivwZ+zClioohaWBCSJqxB
         1KupUKmWZyxaV/9il911eOoSWUbVwqB7LMB/jbtRtfEa0a2m4d0e96tMSfsVcXgvmTSK
         G2IA==
X-Forwarded-Encrypted: i=1; AFNElJ+u0FTIvSJdfV02ooq+K51/XZtdn1PzP/AS6CHa6TSfGSP9Do4fRmBAfjl3KZw7BhLuBMysSrEIW61f8z9cYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wQgd+NcSatnd5g99wQZc3ldNV650kxTJwargQEaKRdFh9+sz
	jlEKZsUtoE5oYAu8JalHPCXL/J78jEVzObl94zTdOVsVgsRkJJARNWnjaBQbtPQF
X-Gm-Gg: Acq92OEmX9K53Q7qdDro3n6T1YaS9ANbKg1PRHOwmt6EIRFdlxTtMQQAGoSo6sED6pY
	PvJbeVd88UCtjHwukaxwcxMLZj02hdxqckt3FXIvxjHWl5VOaCVCZJTcsQbGV5aOK80DPACo/aH
	vGQWuvxaBERBz8OMrsea3BGPpjJ/zAEdbd6y15DktY/+5yCIYUdQcF4Q7FXtwaoCbas0lWkpDLd
	KacGO9wycapIXl3X21vyn9U/Zb9YipMsQ07c6bvNihVkzSZGCktDrM9llp4uIIkpfFk20M+CGWm
	MNogz1rlt3bejpxqMPIh0MD9KiVkWSjYvMl68FHttQUR+zVDpb8SrP1rExAGb1RA6qQv5St1PJx
	HObIhVg24+nIJSEA9iyWxUELTtH8EnJ4TLI/RqSB/4cM1/mre/V9RCJ/FViWhCrKqe9ow28/ocC
	InnDntDlKJC5LPA/WcCVw3+Z+sR+QEmOv1biTY
X-Received: by 2002:a05:701a:c971:b0:12b:fb81:d69b with SMTP id a92af1059eb24-1350542e923mr4001625c88.19.1778953088871;
        Sat, 16 May 2026 10:38:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm13843732c88.8.2026.05.16.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 10:38:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 16 May 2026 10:38:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sander Vanheule <sander@svanheule.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: realtek-otto: enable clock before using I/O
Message-ID: <8cf5e75d-f981-4510-8cee-a39c9a1b67e6@roeck-us.net>
References: <20260515212351.752054-1-sander@svanheule.net>
 <20260515212351.752054-3-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515212351.752054-3-sander@svanheule.net>

On Fri, May 15, 2026 at 11:23:51PM +0200, Sander Vanheule wrote:
> As the watchdog is normally on the same bus as the UART peripheral, the
> bootloader will have ensured the bus' clock is up and running before the
> watchdog driver is probed. Nevertheless, let's do things the right way
> and enable the watchdog's clock before performing I/O accesses.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Applied.

Thanks,
Guenter
