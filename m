Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA331414A34
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507821; cv=none; b=ZpSs1q1ILUdjQZpn7OPWy6dL9gXrl9k9jO5GdQrPOkyHli1rgjdfcq8IUtJKYbcmVsb4OysM3qZSjvj0Fb4HbB6eeser0tiFacHEt7ycJLa556M8hXB4r3Y5gOuWwJE8W5pqMEy5jza0kpvHQGNEBG0C4Rfu5yNgMqTum9cPztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507821; c=relaxed/simple;
	bh=MtF5Fxmphw/oNM/zVvy+umnHlOP+HVsIzMQ7JUars64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2HzguRSveZ4AnMufMiej0AexF1EpLdJZOBIhwkp3m8m50qbCdFwx2lCUNW7i16mmTB7UqrUceabIr5bFC4Fij+3NQkx8g8uZLx6bzGzEkLq5YRT3E/2kxp2Bs3xapHK5mkASXHMCvSFh0gUaWxUcgK/sICNQ1ZnakB+8/Fk4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfsBWdo5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfsBWdo5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1055295b3a.1
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507820; x=1786112620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cjRB82br0ApA+p23VVbRTgbSkeTLuPSgpSvIsWgWyTE=;
        b=YfsBWdo5AItcZXdqs8SCJkrh2i92stOWcvJrOetRakozOOmIy8SCNwDBN6NWLNWjek
         qit7cZiV8C3rf7jtgRM3GsS7hiZKj68OmDjJ2bgLPOoMidgbDMkI53ZmwnBwuPgc7aNO
         lNXwiq5ukIe2cgWADlF9p7NqbUnrkgVkfYyFDXva0mYhku5rFBrSHJu1E+IM2txVzH9F
         nODJqlW3gf1bANSHHPh4UHkxjmaPJQOV9m86nT58oCbZh8xH+EbNBWDUInu1a+ZjKJRN
         Se29nKkSZeHzRaOCGZMLlob4H1dRfOJP/+hH21eZpLWGhVHmSwo+siCCOSsNo6pOdDJR
         w6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507820; x=1786112620;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjRB82br0ApA+p23VVbRTgbSkeTLuPSgpSvIsWgWyTE=;
        b=EUB+6JpBHG4LlxtAZ/Ofp7pWRr4XMsCeuB24V4gqYsks+lsW5ULA4zM+KIaspZwIEI
         AIFqDo+AJJ14uHka7Ko/lOAJT6EqLGG33g+D0o9u+F7BMhqk8JBJ5nSocd4H406HCJDV
         GKIKF2cwXw5hFU5SUQUvAzbIBmphxKoS/cuZA/Vb51OCacsL9nph7yDrAF7iI37x5KJA
         gj2Ny+cWMpa18vbaYO5KflwR4uy0Oeft7rcLBZ5aURJD5JhuOegVK8zBpWzWR80wLw8n
         kXCpjhN4mbS6xHMPC+rHiIu97oBtxJnvEhU6OyvlbsZbkmzNik5NLLSIzdPv/ll9h5d7
         TwyA==
X-Forwarded-Encrypted: i=1; AHgh+RoGKQ5qjo4eqgzXYb6xd2RUbDJh95D9S1ZG+Av4VskDQL+kQ3rnY/VhrVzKxWiTRW2j4zKfLStbQEP2M8fohA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2CtxjxJrWHC+XsIYjRPLhaGDfoX/0rkhlUCQynDE0cK5clsxl
	jkbLoDGvYzdwIMmTmBP9HbzFh+X/qpnlOvjHLUHIkiadHuKdf3n54tAy
X-Gm-Gg: AR+sD11xt4EbrlCDaHopxcNR544HCsDFNj81VUIeQxBiEOVZV0y9C5BKLf7vWpGjQ8e
	8UFY7Zv+moFOFK2zmoV+aRCJz9tuToRf7h/AF7rTDWukp8nNhDyLNve/89THMFB2zCjkK0VRlWn
	C6Ka0OqWmKHRwkSTdxAtFyW7nxKBMhGb0FD91Z1V2BQaNzQBKb+UyqWRj5eQPJ1xu0CHYV5vKeO
	eStA6ccBs0OsUNDtsgCcidwQHE5zbslke1vo19INnW/+jHZnYwVoScaHppsAREdt1q4+yUV9/0J
	wh/w2p70/I+Et0N7wmDZjKuq7mSfbY6SrgQiuV6eKZUPuwk8j/eWHuMW3jtKFymSF/l1oiSu6Jp
	VEkz0rc9qUBxXM4Uw8rh0nsL+agRhuA3dhp5RguuE8SFjSVb8TRidwHvxiLZU3mG08m4Ajifgkd
	YSC7hOfcjOrG0zoyKi3dsndtZWBYdO96xXPHhMkjS3v/Losg4MXpX8/xHWcme0qCNKLQ8UXsk+w
	+50GPGshUKm
X-Received: by 2002:a05:6a00:4503:b0:847:982e:cca0 with SMTP id d2e1a72fcca58-84ed6ec190bmr2126643b3a.19.1785507820016;
        Fri, 31 Jul 2026 07:23:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ee1b049e5sm146426b3a.58.2026.07.31.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:23:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 31 Jul 2026 07:23:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] watchdog: qcom: report bootstatus on IPQ9574 and
 IPQ5332
Message-ID: <4bb022c7-d1d3-461b-809b-0c863083613c@roeck-us.net>
References: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
 <20260728-qcom_wdt_powerunder-v1-2-de8d9e964e7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-qcom_wdt_powerunder-v1-2-de8d9e964e7d@oss.qualcomm.com>

On Tue, Jul 28, 2026 at 04:28:03PM +0530, Kathiravan Thirumoorthy wrote:
> Report bootstatus on IPQ5332 and IPQ9574. These SoCs use different
> restart-reason values from IPQ5424 for watchdog reset and powerunder
> reset events, so add separate match data for them and use it when
> decoding the restart reason.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Applied.

Thanks,
Guenter
