
export enum LogSeverityLevel {
    low     = 'low',
    medium  = 'medium',
    high    = 'high',
}

export class LogEntity {
    public level: LogSeverityLevel;
    public message: string;
    public createdAt: Date;

    constructor( message: string, level: LogSeverityLevel) {
        this.message = message;
        this.level = level;
        this.createdAt = new Date();
    }

    // "{ "level": "high", "message":"Hola Mundo", "createdAt":"1232453T12321321"}"
    static fromJson = (json: string): LogEntity => {
        const {message, level, createdAt} = JSON.parse(json);

        // Aqui se hacen las validaciones para validar los datos del objeto
        // if (message) throw new Error('Message is required');
        const log = new LogEntity(message, level);
        log.createdAt = new Date(createdAt);

        return log;
    }
}