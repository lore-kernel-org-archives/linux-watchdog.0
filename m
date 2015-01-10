Return-path: <mru@mansr.com>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,  Guenter Roeck <linux@roeck-us.net>,  Wim Van Sebroeck <wim@iguana.be>,  Paul Burton <paul.burton@imgtec.com>,  Paul Cercueil <paul@crapouillou.net>,  Maarten ter Huurne <maarten@treewalker.org>,  linux-mips@linux-mips.org,  linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
Date: Sat, 10 Jan 2015 20:08:19 +0000
In-Reply-To: <1420914550-18335-1-git-send-email-lars@metafoo.de> (Lars-Peter
	Clausen's message of "Sat, 10 Jan 2015 19:29:08 +0100")
Message-ID: <yw1xh9vyflfw.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Lars-Peter Clausen <lars@metafoo.de> writes:

> Use the recently introduced do_kernel_restart() function as the default r=
estart
> handler if the platform did not explicitly provide a restart handler. This
> allows use restart handler that have been registered by device drivers to
> restart the machine.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/mips/kernel/reset.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> index 07fc524..36cd80c 100644
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -19,7 +19,7 @@
>   * So handle all using function pointers to machine specific
>   * functions.
>   */
> -void (*_machine_restart)(char *command);
> +void (*_machine_restart)(char *command) =3D do_kernel_restart;
>  void (*_machine_halt)(void);
>  void (*pm_power_off)(void);

There is already a similar patch posted by Kevin Cernekee:
http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
