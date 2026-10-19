Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423433;
	b=cc7E1sL9BZPAb/z/qaWEqh1E4tF9RspUXSLqNkeqcwTZ997fiWmzJh3PpeVjylB4UqHv
	 W/Rkwn7eYmRAsaRw0Z2n7PKyS/CsxM4Drs/Z8FYp2+hJYElKEkeTL0SGO3EvHCekzYQ2D
	 lFZ0Cz29WMgiZmL8bws65rNMhdCTevF6TwoNhJmUVcAc+EbHQApmLyj2ojuGVtwQNECoe
	 2lHB9xJyGK4IT3AO6sZcUsJlrRHGHr+stbirgecgONdSdcJtN1YAqwiAhlkxJqe7s33A1
	 0MLux9/sJwVc8xfH3IbNZfQLfbe51FEXRCrNe5kTw+h3dFrtxjr2l+r4f3TyRLQafuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423433;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=85sDb+x/VzAs09Yh5sx09kwWeEyVdIngX7YU9H09UK0=;
	b=n8H22HMyc1Wz5LdsMfC4nGq1lvHhxM8syWB1yCaZOEzHhx+gonasQs6yqsM1xa89iOPH
	 PyzAA+Z2CV4zWu3hWHtqLh6tqmy1/hQgBufdRPgd+hBsYkaGri0X8dChWD1bOuGTs7UmM
	 s2B06O9Wd9DognlsogMD20dHFRNKfcga9NxgezLumtpBXmCe1+WvAzSLwTg5AG5VZXSE3
	 3jfMLQWYgKlhXAPey0qiZbsVKG8eAxowlo/wtyGiqwvs79lJwnUeJ5USPcrNEP3QkBYj0
	 Xt0vgquH0mUtF53vN0sO1fYIOX0X+Dkv9hXzm+EhRSM6q0SGiyZW/7u7DOI+YpC+7iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hi7Vor/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CC60ACCFD;
	Mon, 19 Oct 2026 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hi7Vor/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E9F1F000C6;
	Mon, 19 Oct 2026 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423432;
	bh=85sDb+x/VzAs09Yh5sx09kwWeEyVdIngX7YU9H09UK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hi7Vor/l37RNbw2eM+rFjb1sHxjLmnHgXzKkV57X9mrMGqt20PCf+VK7xT7Ahce5u
	 mFazqA1XCVMPywiNM+urVRDLFSAQpYsOS1gJtcu/bTQvQqP8yhflkGg5Y4nIpfO47T
	 9iFkL3CMBu8pvEDRHMLnFDsxOiD0I2y7ebdHybR3cKCeldPCb4UBpSwB/3k2t9q+uH
	 aX5N3NI5sDxatDdjVmOcn3Z2/OSPjvE3khS+C46TqNE175xTMQi+2FeyaKuQBlsZz6
	 j1TO+oDmuGRHWIPwjsFSUjmnCW3zUPW2AS9w4wpvYkAua3Hj/DHjL4pFoCoB9G3Ug+
	 uPInN5Y7r1w2w==
Date: Mon, 19 Oct 2026 15:23:49 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 5/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
Message-ID: <atY2BXHPAZ95vCkD@google.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-5-b6f6b60a9566@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-5-b6f6b60a9566@bootlin.com>

On Tue, Oct 13, 2026 at 03:58:49PM +0200, Paul Louvel wrote:
> Instead of using global variables, store Super I/O related
> configurations in platform data.
>
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

With a few nits,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

>  /*
>   * On some systems, the NCT6791D comes with a companion chip and the
>   * watchdog function is in this companion chip. We must use a different
>   * unlocking sequence to access the companion chip.
>   */
> -static int __init wdt_use_alt_key(const struct dmi_system_id *d)
> -{
> -	wdt_cfg_enter = 0x88;
> -	wdt_cfg_leave = 0xBB;
>  

Please remove the blank line as well.

> -	return 0;
> -}
> +static const struct w83627hf_sio_pdata w83627hf_sio_pdata_alt = {
> +	.cfg_enter = 0x88,
> +	.cfg_leave = 0xBB
> +};
>  
>  static const struct dmi_system_id wdt_dmi_table[] __initconst = {
>  	{
> @@ -554,7 +564,7 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
>  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "INVES"),
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
>  		},
> -		.callback = wdt_use_alt_key,
> +		.driver_data = (void *) &w83627hf_sio_pdata_alt
                                       ^
Please remove the extra space.
